---
name: issue-link-manager
description: Create native parent-child and blocked-by relationships between issues. Use when a feature or task needs a parent issue, sub-issue relationship, or explicit dependency link.
---

Use this skill when the planning flow has already identified issue relationships and those links should be materialized in GitHub.

## Preferred commands

Add a child issue under a parent:

```bash
scripts/github_workflow.rb link add-sub-issue \
  --repo owner/repo \
  --parent 12 \
  --child 34
```

Mark an issue as blocked by another issue:

```bash
scripts/github_workflow.rb link add-blocked-by \
  --repo owner/repo \
  --issue 34 \
  --blocking 56
```

## Rules

- Use parent-child links for hierarchy.
- Use `blocked by` links for sequencing constraints.
- Preserve both when the work needs both structure and dependency tracking.
- Prefer native GitHub relationships over body-only references.

## Guardrails

- Do not invent dependencies without evidence.
- Do not create hierarchy that conflicts with the project brief -> epic -> feature -> task model.
- Do not use blocking links to encode soft associations.
