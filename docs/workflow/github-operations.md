# GitHub operations layer

This repo includes a local operations CLI that turns planning outputs into GitHub-native mutations.

Use `scripts/github_workflow.rb` for:

- bootstrapping labels, milestones, and Project fields from `config/workflow-model.yml`
- creating or updating issues from a structured spec file
- adding issues to a GitHub Project and setting Project field values
- creating native sub-issue and `blocked by` relationships
- syncing durable repo docs from the same planning spec

## Why there is a local CLI

The planning skills decide **what** should exist. The operations layer decides **how** to create or update it safely and consistently.

Keeping this logic in one local CLI gives the skills a stable interface and keeps GitHub API details out of the planning prompts.

## Commands

### Validate the workflow model

```bash
scripts/github_workflow.rb validate-config
```

### Bootstrap repository workflow surfaces

```bash
scripts/github_workflow.rb bootstrap \
  --repo owner/repo \
  --project-owner owner \
  --project-number 1
```

What it does:

- syncs labels from `config/workflow-model.yml`
- ensures default milestones exist
- ensures required Project fields exist
- prints the recommended Project views that should exist

If you need the CLI to create a Project first:

```bash
scripts/github_workflow.rb bootstrap \
  --repo owner/repo \
  --project-owner owner \
  --create-project \
  --project-title "Planning"
```

## Apply an issue spec

```bash
scripts/github_workflow.rb issue apply \
  --repo owner/repo \
  --spec docs/workflow/examples/feature-team-invites.json
```

This command can:

- create or update the issue
- apply labels and milestone
- add the issue to a GitHub Project
- set `Status`, `Readiness`, `Mode`, `Priority`, and `Risk`
- create parent/sub-issue and `blocked by` relationships
- sync the matching repo doc if an `artifact` block exists in the spec

## Sync Project state for an existing issue

```bash
scripts/github_workflow.rb project sync-item \
  --repo owner/repo \
  --project-owner owner \
  --project-number 1 \
  --issue-number 42 \
  --field Status=planned \
  --field Readiness=draft
```

## Link issues natively

Add a sub-issue:

```bash
scripts/github_workflow.rb link add-sub-issue \
  --repo owner/repo \
  --parent 12 \
  --child 34
```

Add a `blocked by` dependency:

```bash
scripts/github_workflow.rb link add-blocked-by \
  --repo owner/repo \
  --issue 34 \
  --blocking 56
```

## Sync a repo-side planning document

```bash
scripts/github_workflow.rb artifact sync \
  --spec docs/workflow/examples/project-brief-team-collab.json
```

## Spec format

The operations CLI expects a JSON spec. Example shape:

```json
  {
    "kind": "feature",
    "slug": "team-invites",
    "issue": {
      "title": "[Feature] Team invites",
      "body": "## User outcome\nAdmins can invite teammates by email.\n\n## Detailed UI/UX direction\nPut the Invite teammate button in the top-right of Team settings. Clicking it opens a modal with an email field and primary CTA.",
      "labels": ["type/feature", "area/product", "mode/greenfield"],
      "milestone": "M2 - Core MVP workflows"
    },
  "project": {
    "owner": "example-org",
    "number": 1,
    "fields": {
      "Status": "planned",
      "Readiness": "draft",
      "Mode": "greenfield",
      "Priority": "high",
      "Risk": "medium"
    }
  },
  "relationships": {
    "parent_issue": 12,
    "blocked_by": [56]
  },
    "artifact": {
      "title": "Feature spec: Team invites",
      "summary": "Allow workspace admins to invite teammates by email.",
      "sections": {
        "User outcome": "Workspace admins can invite teammates by email.",
        "Detailed UI/UX direction": [
          "Put the Invite teammate button in the top-right of Team settings.",
          "Open a modal with an email field and primary CTA.",
          "Show pending invites below the current member list."
        ],
        "Acceptance criteria": [
          "Admins can send an invite to a valid email address.",
          "Users see the invite state in the team management screen."
        ]
      }
  }
}
```

## Current limits

- Project views are documented and printed, but not created automatically.
- The operations CLI assumes relationships are created within the same repository.
- The spec format is intentionally simple and optimized for local skills, not for public API compatibility.
