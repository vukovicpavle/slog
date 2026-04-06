#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'fileutils'
require 'json'
require 'open3'
require 'optparse'
require 'pathname'
require 'shellwords'
require 'tempfile'
require 'yaml'

class WorkflowError < StandardError; end

class WorkflowConfig
  attr_reader :data, :root

  def initialize(root)
    @root = root
    config_path = root.join("config/workflow-model.yml")
    @data = YAML.safe_load(File.read(config_path), aliases: true)
  end

  def github
    data.fetch("github")
  end

  def api_version
    github.fetch("api_version").to_s
  end

  def labels
    github.fetch("labels")
  end

  def project_fields
    github.fetch("project_fields")
  end

  def recommended_views
    github.fetch("recommended_views")
  end

  def milestones
    data.fetch("milestones").fetch("default_sequence")
  end

  def artifact_path_for(kind, slug)
    pattern = data.fetch("artifacts").fetch(kind).fetch("doc_path_pattern")
    root.join(pattern.gsub("{slug}", slug))
  end
end

class GhRunner
  def initialize(api_version:, dry_run: false)
    @api_version = api_version
    @dry_run = dry_run
  end

  def run(*command, json: false)
    command = command.flatten.compact.map(&:to_s)
    if @dry_run
      puts "DRY RUN: #{Shellwords.join(command)}"
      return nil
    end

    stdout, stderr, status = Open3.capture3(*command)
    raise WorkflowError, stderr.strip.empty? ? "command failed: #{Shellwords.join(command)}" : stderr.strip unless status.success?

    return nil if stdout.strip.empty?
    return JSON.parse(stdout) if json

    stdout
  end

  def api(endpoint, method: "GET", body: nil)
    command = [
      "gh", "api", endpoint,
      "-H", "Accept: application/vnd.github+json",
      "-H", "X-GitHub-Api-Version: #{@api_version}"
    ]
    command += ["-X", method] unless method == "GET"

    tempfile = nil
    if body
      tempfile = Tempfile.new(["github-workflow", ".json"])
      tempfile.write(JSON.pretty_generate(body))
      tempfile.close
      command += ["--input", tempfile.path]
    end

    run(command, json: true)
  ensure
    tempfile&.unlink
  end
end

class GitHubWorkflowCLI
  def initialize(argv, root: Pathname(__dir__).join("..").expand_path)
    @argv = argv.dup
    @root = root
    @config = WorkflowConfig.new(root)
  end

  def run
    command = @argv.shift

    case command
    when "bootstrap"
      bootstrap(@argv)
    when "issue"
      issue(@argv)
    when "project"
      project(@argv)
    when "link"
      link(@argv)
    when "artifact"
      artifact(@argv)
    when "validate-config"
      validate_config
    else
      puts usage
      exit(command.nil? ? 0 : 1)
    end
  rescue WorkflowError => e
    warn "error: #{e.message}"
    exit 1
  end

  private

  def usage
    <<~USAGE
      Usage:
        scripts/github_workflow.rb validate-config
        scripts/github_workflow.rb bootstrap [options]
        scripts/github_workflow.rb issue apply --repo owner/repo --spec path/to/spec.json [--dry-run]
        scripts/github_workflow.rb project sync-item --repo owner/repo --project-owner owner --project-number 1 --issue-number 42 --field Status=planned
        scripts/github_workflow.rb link add-sub-issue --repo owner/repo --parent 12 --child 34
        scripts/github_workflow.rb link add-blocked-by --repo owner/repo --issue 34 --blocking 56
        scripts/github_workflow.rb artifact sync --spec path/to/spec.json
    USAGE
  end

  def runner(dry_run:)
    GhRunner.new(api_version: @config.api_version, dry_run: dry_run)
  end

  def resolve_repo(repo_arg, gh)
    return repo_arg if repo_arg && repo_arg.include?("/")

    repo = gh.run("gh", "repo", "view", "--json", "nameWithOwner", "--jq", ".nameWithOwner")&.strip
    raise WorkflowError, "unable to resolve repository; pass --repo owner/repo" if repo.nil? || repo.empty?

    repo
  end

  def split_repo(repo)
    owner, name = repo.split("/", 2)
    raise WorkflowError, "repository must be in owner/repo form" if owner.nil? || name.nil?

    [owner, name]
  end

  def milestone_title(entry)
    "#{entry.fetch('id').upcase} - #{entry.fetch('name')}"
  end

  def parse_json_file(path)
    JSON.parse(File.read(@root.join(path)))
  end

  def extract_collection(payload, preferred_key)
    return payload.fetch(preferred_key) if payload.is_a?(Hash) && payload.key?(preferred_key)
    return payload.fetch("items") if payload.is_a?(Hash) && payload.key?("items")
    return payload.fetch("fields") if payload.is_a?(Hash) && payload.key?("fields")
    return payload.fetch("projects") if payload.is_a?(Hash) && payload.key?("projects")
    return payload if payload.is_a?(Array)

    []
  end

  def validate_config
    required_sections = %w[agent lifecycles fields gates artifacts milestones labels github rules]
    missing = required_sections.reject { |key| @config.data.key?(key) }
    raise WorkflowError, "missing required sections: #{missing.join(', ')}" unless missing.empty?

    puts "workflow model: ok"
    puts "labels: #{@config.labels.count}"
    puts "project fields: #{@config.project_fields.count}"
    puts "milestones: #{@config.milestones.count}"
    puts "recommended views: #{@config.recommended_views.count}"
  end

  def bootstrap(argv)
    options = {
      labels: true,
      milestones: true,
      fields: true,
      dry_run: false
    }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: scripts/github_workflow.rb bootstrap [options]"
      opts.on("--repo REPO", "Repository in owner/repo form") { |value| options[:repo] = value }
      opts.on("--project-owner OWNER", "Project owner login") { |value| options[:project_owner] = value }
      opts.on("--project-number NUMBER", Integer, "Existing project number") { |value| options[:project_number] = value }
      opts.on("--project-title TITLE", "Project title to create or reuse") { |value| options[:project_title] = value }
      opts.on("--create-project", "Create the project if it does not exist") { options[:create_project] = true }
      opts.on("--[no-]labels", "Sync labels") { |value| options[:labels] = value }
      opts.on("--[no-]milestones", "Sync milestones") { |value| options[:milestones] = value }
      opts.on("--[no-]fields", "Sync project fields") { |value| options[:fields] = value }
      opts.on("--dry-run", "Print commands without mutating GitHub") { options[:dry_run] = true }
    end
    parser.parse!(argv)

    gh = runner(dry_run: options[:dry_run])
    repo = resolve_repo(options[:repo], gh)
    owner, name = split_repo(repo)

    sync_labels(owner, name, gh) if options[:labels]
    sync_milestones(owner, name, gh) if options[:milestones]

    project_number = options[:project_number]
    if options[:fields]
      project_owner = options[:project_owner] || owner
      project_number ||= ensure_project_number(project_owner, options[:project_title], options[:create_project], gh)
      if project_number
        sync_project_fields(project_owner, project_number, gh)
        print_recommended_views
      else
        warn "warning: no project selected; skipping project field sync"
      end
    end
  end

  def sync_labels(owner, repo, gh)
    @config.labels.each do |label|
      gh.run(
        "gh", "label", "create", label.fetch("name"),
        "--repo", "#{owner}/#{repo}",
        "--color", label.fetch("color"),
        "--description", label.fetch("description"),
        "--force"
      )
    end
  end

  def sync_milestones(owner, repo, gh)
    existing = gh.api("repos/#{owner}/#{repo}/milestones?state=all&per_page=100") || []
    existing_by_title = existing.each_with_object({}) { |milestone, memo| memo[milestone.fetch("title")] = milestone }

    @config.milestones.each do |milestone|
      title = milestone_title(milestone)
      description = milestone["description"]
      current = existing_by_title[title]

      if current
        next if description.nil? || current["description"] == description

        gh.api(
          "repos/#{owner}/#{repo}/milestones/#{current.fetch('number')}",
          method: "PATCH",
          body: { description: description }
        )
      else
        body = { title: title }
        body[:description] = description if description
        gh.api("repos/#{owner}/#{repo}/milestones", method: "POST", body: body)
      end
    end
  end

  def ensure_project_number(project_owner, project_title, create_project, gh)
    return nil if project_title.nil? && !create_project

    projects = gh.run("gh", "project", "list", "--owner", project_owner, "--format", "json", json: true) || []
    project_list = extract_collection(projects, "projects")
    existing = project_list.find { |project| project["title"] == project_title } if project_title
    return existing["number"] if existing
    return nil unless create_project && project_title

    gh.run("gh", "project", "create", "--owner", project_owner, "--title", project_title, "--format", "json", json: true)
    projects = gh.run("gh", "project", "list", "--owner", project_owner, "--format", "json", json: true) || []
    project_list = extract_collection(projects, "projects")
    created = project_list.find { |project| project["title"] == project_title }
    raise WorkflowError, "project was created but could not be found by title #{project_title.inspect}" unless created

    created["number"]
  end

  def sync_project_fields(project_owner, project_number, gh)
    fields_payload = gh.run(
      "gh", "project", "field-list", project_number.to_s,
      "--owner", project_owner,
      "--format", "json",
      json: true
    ) || []
    existing_fields = extract_collection(fields_payload, "fields")
    existing_by_name = existing_fields.each_with_object({}) { |field, memo| memo[field.fetch("name")] = field }

    @config.project_fields.each do |field|
      current = existing_by_name[field.fetch("name")]
      if current.nil?
        command = [
          "gh", "project", "field-create", project_number.to_s,
          "--owner", project_owner,
          "--name", field.fetch("name"),
          "--data-type", field.fetch("data_type")
        ]
        if field.fetch("data_type") == "SINGLE_SELECT"
          command += ["--single-select-options", field.fetch("options").join(",")]
        end
        gh.run(command)
      elsif field.fetch("data_type") == "SINGLE_SELECT"
        current_options = Array(current["options"]).map { |option| option["name"] }
        missing = field.fetch("options") - current_options
        warn "warning: project field #{field.fetch('name')} is missing options: #{missing.join(', ')}" unless missing.empty?
      end
    end
  end

  def print_recommended_views
    puts "Recommended project views:"
    @config.recommended_views.each do |view|
      puts "- #{view.fetch('name')}: #{view.fetch('description')} (filter: #{view.fetch('filter')})"
    end
  end

  def issue(argv)
    subcommand = argv.shift
    case subcommand
    when "apply"
      issue_apply(argv)
    else
      raise WorkflowError, "unknown issue subcommand #{subcommand.inspect}"
    end
  end

  def issue_apply(argv)
    options = { dry_run: false, sync_artifact: true }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: scripts/github_workflow.rb issue apply --repo owner/repo --spec path/to/spec.json"
      opts.on("--repo REPO", "Repository in owner/repo form") { |value| options[:repo] = value }
      opts.on("--spec PATH", "JSON issue spec path") { |value| options[:spec] = value }
      opts.on("--dry-run", "Print actions without mutating GitHub") { options[:dry_run] = true }
      opts.on("--[no-]sync-artifact", "Sync the repo-side artifact from the spec") { |value| options[:sync_artifact] = value }
    end
    parser.parse!(argv)

    raise WorkflowError, "--spec is required" unless options[:spec]

    gh = runner(dry_run: options[:dry_run])
    repo = resolve_repo(options[:repo], gh)
    owner, name = split_repo(repo)
    spec = parse_json_file(options[:spec])

    if options[:dry_run]
      puts "DRY RUN SPEC: #{options[:spec]}"
      puts "Would #{spec.dig('issue', 'number') ? 'update' : 'create'} issue #{spec.dig('issue', 'title').inspect} in #{repo}"
      puts "Would sync artifact for #{spec['kind']} #{spec['slug']}" if options[:sync_artifact] && spec["artifact"]
      return
    end

    issue_record = apply_issue_spec(owner, name, spec, gh)

    if spec["project"]
      sync_project_item(
        repo: repo,
        project_owner: spec.fetch("project").fetch("owner"),
        project_number: spec.fetch("project").fetch("number"),
        issue_number: issue_record.fetch("number"),
        fields: spec.fetch("project").fetch("fields", {}),
        gh: gh
      )
    end

    apply_relationships(owner, name, issue_record, spec["relationships"], gh) if spec["relationships"]
    sync_artifact_from_spec(spec, issue_record: issue_record) if options[:sync_artifact] && spec["artifact"]

    puts issue_record.fetch("html_url")
  end

  def apply_issue_spec(owner, repo, spec, gh)
    issue = spec.fetch("issue")
    payload = {
      title: issue.fetch("title"),
      body: issue["body"] || render_markdown(spec)
    }
    payload[:labels] = issue["labels"] if issue["labels"]
    if issue["milestone"]
      payload[:milestone] = resolve_milestone_number(owner, repo, issue.fetch("milestone"), gh)
    end
    payload[:assignees] = issue["assignees"] if issue["assignees"]

    if issue["number"]
      gh.api("repos/#{owner}/#{repo}/issues/#{issue.fetch('number')}", method: "PATCH", body: payload)
    else
      gh.api("repos/#{owner}/#{repo}/issues", method: "POST", body: payload)
    end
  end

  def resolve_milestone_number(owner, repo, title, gh)
    milestones = gh.api("repos/#{owner}/#{repo}/milestones?state=all&per_page=100") || []
    milestone = milestones.find { |candidate| candidate["title"] == title }
    raise WorkflowError, "milestone #{title.inspect} was not found in #{owner}/#{repo}" unless milestone

    milestone.fetch("number")
  end

  def project(argv)
    subcommand = argv.shift
    case subcommand
    when "sync-item"
      project_sync_item(argv)
    else
      raise WorkflowError, "unknown project subcommand #{subcommand.inspect}"
    end
  end

  def project_sync_item(argv)
    options = { dry_run: false, fields: {} }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: scripts/github_workflow.rb project sync-item [options]"
      opts.on("--repo REPO", "Repository in owner/repo form") { |value| options[:repo] = value }
      opts.on("--project-owner OWNER", "Project owner login") { |value| options[:project_owner] = value }
      opts.on("--project-number NUMBER", Integer, "Project number") { |value| options[:project_number] = value }
      opts.on("--issue-number NUMBER", Integer, "Issue number in the repository") { |value| options[:issue_number] = value }
      opts.on("--field NAME=VALUE", "Project field assignment; repeatable") do |value|
        name, field_value = value.split("=", 2)
        raise WorkflowError, "--field requires NAME=VALUE" unless name && field_value

        options[:fields][name] = field_value
      end
      opts.on("--dry-run", "Print actions without mutating GitHub") { options[:dry_run] = true }
    end
    parser.parse!(argv)

    raise WorkflowError, "--project-owner is required" unless options[:project_owner]
    raise WorkflowError, "--project-number is required" unless options[:project_number]
    raise WorkflowError, "--issue-number is required" unless options[:issue_number]

    gh = runner(dry_run: options[:dry_run])
    repo = resolve_repo(options[:repo], gh)
    sync_project_item(
      repo: repo,
      project_owner: options[:project_owner],
      project_number: options[:project_number],
      issue_number: options[:issue_number],
      fields: options[:fields],
      gh: gh
    )
  end

  def sync_project_item(repo:, project_owner:, project_number:, issue_number:, fields:, gh:)
    owner, name = split_repo(repo)
    issue_html_url = "https://github.com/#{owner}/#{name}/issues/#{issue_number}"
    issue_api_url = "https://api.github.com/repos/#{owner}/#{name}/issues/#{issue_number}"

    if gh.instance_variable_get(:@dry_run)
      gh.run("gh", "project", "item-add", project_number.to_s, "--owner", project_owner, "--url", issue_html_url)
      unless fields.empty?
        puts "DRY RUN: would set project fields #{fields.inspect} on issue ##{issue_number}"
      end
      return
    end

    project = gh.run("gh", "project", "view", project_number.to_s, "--owner", project_owner, "--format", "json", json: true) || {}
    project_id = project["id"] || project.dig("project", "id")
    raise WorkflowError, "unable to determine project id for project #{project_number}" unless project_id

    items_payload = gh.run("gh", "project", "item-list", project_number.to_s, "--owner", project_owner, "--format", "json", json: true) || []
    items = extract_collection(items_payload, "items")
    item = items.find do |candidate|
      urls = [
        candidate["content_url"],
        candidate["url"],
        candidate.dig("content", "url"),
        candidate.dig("content", "html_url")
      ].compact
      numbers = [candidate["number"], candidate.dig("content", "number")].compact
      urls.include?(issue_html_url) || urls.include?(issue_api_url) || numbers.include?(issue_number)
    end

    item ||= gh.run(
      "gh", "project", "item-add", project_number.to_s,
      "--owner", project_owner,
      "--url", issue_html_url,
      "--format", "json",
      json: true
    )

    item_id = item["id"]
    raise WorkflowError, "unable to determine project item id for issue ##{issue_number}" unless item_id

    return if fields.empty?

    fields_payload = gh.run(
      "gh", "project", "field-list", project_number.to_s,
      "--owner", project_owner,
      "--format", "json",
      json: true
    ) || []
    project_fields = extract_collection(fields_payload, "fields")

    fields.each do |field_name, value|
      definition = project_fields.find { |field| field["name"] == field_name }
      raise WorkflowError, "project field #{field_name.inspect} not found in project #{project_number}" unless definition

      command = [
        "gh", "project", "item-edit",
        "--id", item_id,
        "--project-id", project_id,
        "--field-id", definition.fetch("id")
      ]

      case definition["dataType"]
      when "SINGLE_SELECT"
        option = Array(definition["options"]).find { |candidate| candidate["name"] == value }
        raise WorkflowError, "option #{value.inspect} not found for field #{field_name.inspect}" unless option

        command += ["--single-select-option-id", option.fetch("id")]
      when "DATE"
        command += ["--date", value]
      when "NUMBER"
        command += ["--number", value]
      else
        command += ["--text", value]
      end

      gh.run(command)
    end
  end

  def link(argv)
    subcommand = argv.shift
    case subcommand
    when "add-sub-issue"
      link_add_sub_issue(argv)
    when "add-blocked-by"
      link_add_blocked_by(argv)
    else
      raise WorkflowError, "unknown link subcommand #{subcommand.inspect}"
    end
  end

  def link_add_sub_issue(argv)
    options = { dry_run: false }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: scripts/github_workflow.rb link add-sub-issue --repo owner/repo --parent 12 --child 34"
      opts.on("--repo REPO", "Repository in owner/repo form") { |value| options[:repo] = value }
      opts.on("--parent NUMBER", Integer, "Parent issue number") { |value| options[:parent] = value }
      opts.on("--child NUMBER", Integer, "Child issue number") { |value| options[:child] = value }
      opts.on("--dry-run", "Print actions without mutating GitHub") { options[:dry_run] = true }
    end
    parser.parse!(argv)

    raise WorkflowError, "--parent is required" unless options[:parent]
    raise WorkflowError, "--child is required" unless options[:child]

    gh = runner(dry_run: options[:dry_run])
    repo = resolve_repo(options[:repo], gh)
    owner, name = split_repo(repo)
    if options[:dry_run]
      puts "DRY RUN: would resolve issue ##{options[:child]} in #{repo} and add it as a sub-issue of ##{options[:parent]}"
      return
    end

    child_issue = fetch_issue(owner, name, options[:child], gh)
    ensure_sub_issue(owner, name, options[:parent], child_issue.fetch("id"), gh)
  end

  def link_add_blocked_by(argv)
    options = { dry_run: false }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: scripts/github_workflow.rb link add-blocked-by --repo owner/repo --issue 34 --blocking 56"
      opts.on("--repo REPO", "Repository in owner/repo form") { |value| options[:repo] = value }
      opts.on("--issue NUMBER", Integer, "Issue number to mark blocked") { |value| options[:issue] = value }
      opts.on("--blocking NUMBER", Integer, "Issue number that blocks the current issue") { |value| options[:blocking] = value }
      opts.on("--dry-run", "Print actions without mutating GitHub") { options[:dry_run] = true }
    end
    parser.parse!(argv)

    raise WorkflowError, "--issue is required" unless options[:issue]
    raise WorkflowError, "--blocking is required" unless options[:blocking]

    gh = runner(dry_run: options[:dry_run])
    repo = resolve_repo(options[:repo], gh)
    owner, name = split_repo(repo)
    if options[:dry_run]
      puts "DRY RUN: would resolve blocker issue ##{options[:blocking]} in #{repo} and link it as blocked-by for ##{options[:issue]}"
      return
    end

    blocker = fetch_issue(owner, name, options[:blocking], gh)
    ensure_blocked_by(owner, name, options[:issue], blocker.fetch("id"), gh)
  end

  def apply_relationships(owner, repo, issue_record, relationships, gh)
    if relationships["parent_issue"]
      ensure_sub_issue(owner, repo, relationships.fetch("parent_issue"), issue_record.fetch("id"), gh)
    end

    Array(relationships["blocked_by"]).each do |blocking_issue_number|
      blocker = fetch_issue(owner, repo, blocking_issue_number, gh)
      ensure_blocked_by(owner, repo, issue_record.fetch("number"), blocker.fetch("id"), gh)
    end
  end

  def fetch_issue(owner, repo, issue_number, gh)
    gh.api("repos/#{owner}/#{repo}/issues/#{issue_number}")
  end

  def ensure_sub_issue(owner, repo, parent_issue_number, child_issue_id, gh)
    endpoint = "repos/#{owner}/#{repo}/issues/#{parent_issue_number}/sub-issues"

    if gh.instance_variable_get(:@dry_run)
      gh.api(endpoint, method: "POST", body: { sub_issue_id: child_issue_id })
      return
    end

    existing = gh.api(endpoint) || []
    return if existing.any? { |issue| issue["id"] == child_issue_id }

    gh.api(endpoint, method: "POST", body: { sub_issue_id: child_issue_id })
  end

  def ensure_blocked_by(owner, repo, issue_number, blocking_issue_id, gh)
    endpoint = "repos/#{owner}/#{repo}/issues/#{issue_number}/dependencies/blocked_by"

    if gh.instance_variable_get(:@dry_run)
      gh.api(endpoint, method: "POST", body: { issue_id: blocking_issue_id })
      return
    end

    existing = gh.api(endpoint) || []
    return if existing.any? { |issue| issue["id"] == blocking_issue_id }

    gh.api(endpoint, method: "POST", body: { issue_id: blocking_issue_id })
  end

  def artifact(argv)
    subcommand = argv.shift
    case subcommand
    when "sync"
      artifact_sync(argv)
    else
      raise WorkflowError, "unknown artifact subcommand #{subcommand.inspect}"
    end
  end

  def artifact_sync(argv)
    options = { dry_run: false }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: scripts/github_workflow.rb artifact sync --spec path/to/spec.json"
      opts.on("--spec PATH", "JSON spec path") { |value| options[:spec] = value }
      opts.on("--dry-run", "Print the target path without writing") { options[:dry_run] = true }
    end
    parser.parse!(argv)

    raise WorkflowError, "--spec is required" unless options[:spec]

    spec = parse_json_file(options[:spec])
    if options[:dry_run]
      path = artifact_output_path(spec)
      puts "DRY RUN: would write #{path.relative_path_from(@root)}"
      return
    end

    path = sync_artifact_from_spec(spec)
    puts path.relative_path_from(@root)
  end

  def artifact_output_path(spec)
    artifact = spec.fetch("artifact")
    explicit_path = artifact["path"]
    return @root.join(explicit_path) if explicit_path

    kind = spec["kind"] || artifact["kind"]
    slug = spec["slug"] || artifact["slug"]
    raise WorkflowError, "artifact sync requires kind and slug when no explicit artifact.path is provided" unless kind && slug

    @config.artifact_path_for(kind, slug)
  end

  def sync_artifact_from_spec(spec, issue_record: nil)
    path = artifact_output_path(spec)
    FileUtils.mkdir_p(path.dirname)
    File.write(path, render_markdown(spec, issue_record: issue_record))
    path
  end

  def render_markdown(spec, issue_record: nil)
    artifact = spec.fetch("artifact")
    lines = []
    lines << "# #{artifact['title'] || spec.dig('issue', 'title') || spec['slug']}"
    lines << ""

    if issue_record
      lines << "> Linked issue: #{issue_record.fetch('html_url')}"
      lines << ""
    end

    if artifact["summary"]
      lines << artifact.fetch("summary")
      lines << ""
    end

    artifact.fetch("sections", {}).each do |heading, content|
      lines << "## #{heading}"
      lines << ""
      lines.concat(render_section_content(content))
      lines << ""
    end

    lines.join("\n").rstrip + "\n"
  end

  def render_section_content(content, depth: 0)
    case content
    when String
      content.split("\n")
    when Array
      content.flat_map do |item|
        case item
        when String
          ["#{'  ' * depth}- #{item}"]
        when Hash
          item.flat_map do |key, value|
            nested = render_section_content(value, depth: depth + 1)
            if nested.length == 1
              ["#{'  ' * depth}- **#{key}:** #{nested.first.sub(/\A- /, '')}"]
            else
              ["#{'  ' * depth}- **#{key}:**", *nested]
            end
          end
        else
          ["#{'  ' * depth}- #{item}"]
        end
      end
    when Hash
      content.flat_map do |key, value|
        nested = render_section_content(value, depth: depth + 1)
        if nested.length == 1
          ["#{'  ' * depth}- **#{key}:** #{nested.first.sub(/\A- /, '')}"]
        else
          ["#{'  ' * depth}- **#{key}:**", *nested]
        end
      end
    else
      [content.to_s]
    end
  end
end

GitHubWorkflowCLI.new(ARGV).run
