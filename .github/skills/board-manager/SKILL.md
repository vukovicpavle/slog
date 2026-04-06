---
name: board-manager
description: Add issues to a GitHub Project and keep Project field values aligned with the workflow model. Use when planning work must update Status, Readiness, Mode, Priority, or Risk on a Project item.
---

Use this skill after an issue already exists and needs its Project state aligned.

## Goal

Keep GitHub Project state consistent with `config/workflow-model.yml` so the board is the source of truth for mutable workflow state.

## Preferred command

```bash
scripts/github_workflow.rb project sync-item \
  --repo owner/repo \
  --project-owner owner \
  --project-number 1 \
  --issue-number 42 \
  --field Status=planned \
  --field Readiness=draft
```

## Rules

- Add the issue to the Project if it is not already there.
- Set Project fields from the workflow model rather than inventing new values.
- Use Project fields for mutable state, not labels.
- If a required field is missing from the Project, route to `github-bootstrap`.

## Guardrails

- Do not repurpose labels as a board-state workaround.
- Do not create new field names ad hoc.
- Do not change field values without a planning reason grounded in the lifecycle.
