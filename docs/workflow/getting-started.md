# Getting started

Use this guide when you create a new repository from the template or adopt the template into an existing repository.

## 1. Bootstrap GitHub workflow surfaces

Pick the repository and the GitHub Project you want to use, then run:

```bash
scripts/github_workflow.rb bootstrap \
  --repo owner/repo \
  --project-owner owner \
  --project-number 1
```

If you need the CLI to create the Project first:

```bash
scripts/github_workflow.rb bootstrap \
  --repo owner/repo \
  --project-owner owner \
  --create-project \
  --project-title "Planning"
```

This ensures:

- labels
- default milestones
- required Project fields

It also prints the recommended Project views you should create manually.

## 2. Start with Copilot Chat in the repository

The public entry point is `workflow-orchestrator`.

Use prompts like:

- **Greenfield:** "I want to build a web app for restaurant staff scheduling."
- **Adoption:** "We want to apply this workflow to our current repo."
- **Feature:** "Plan a feature for team invites."

## 3. Let the agent shape the work before it creates artifacts

The agent should:

- identify project, adoption, or feature mode
- ask one focused question at a time
- draft the right brief or spec
- capture high-level UI/UX direction for projects and detailed UI/UX direction for user-facing features
- refuse issue generation until the relevant ready gate passes

## 4. Materialize approved work into GitHub

Once the gate passes and the user confirms, the agent can use `github-operator` and related ops skills to:

- create or update issues
- attach milestones
- add items to a GitHub Project
- set `Status`, `Readiness`, `Mode`, `Priority`, and `Risk`
- create native issue links
- sync durable repo docs

## 5. Hand off to humans at `Ready for Assignment`

Planning ends when work is explicitly marked `ready-for-assignment`.

After that:

- humans assign the issue
- delivery work happens in branches and PRs
- governance skills handle PR linking, done checks, release prep, and retro capture

## 6. Use the examples to test the flow

Examples live in `docs/workflow/examples/`:

- `project-brief-team-collab.json`
- `adoption-existing-repo.json`
- `feature-team-invites.json`

You can dry-run them with:

```bash
scripts/github_workflow.rb issue apply \
  --repo owner/repo \
  --spec docs/workflow/examples/feature-team-invites.json \
  --dry-run
```
