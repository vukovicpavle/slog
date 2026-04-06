---
name: github-operator
description: Materialize approved planning work into GitHub issues, Project state, relationships, and repo docs. Use after the relevant ready gate passes and the user has approved creation or update of GitHub artifacts.
---

Use this skill after readiness is confirmed and the next step is to create or update GitHub-native artifacts.

## Preferred command

```bash
scripts/github_workflow.rb issue apply \
  --repo owner/repo \
  --spec path/to/spec.json
```

## What the command can do

- create or update the issue
- apply labels and milestone
- sync the issue into a GitHub Project
- set Project field values
- create parent-child and blocked-by relationships
- sync the matching repo doc

## Process

1. Confirm the relevant ready gate has passed.
2. Prepare a JSON spec containing `issue`, `project`, `relationships`, and `artifact` data.
3. Run `issue apply`.
4. If only the board state changes, use `board-manager`.
5. If only links change, use `issue-link-manager`.
6. If only docs change, use `artifact-sync`.

## Guardrails

- Do not run before project, adoption, or feature readiness is satisfied.
- Do not create implementation tasks from an unready feature.
- Do not mutate a live backlog broadly in adoption mode without approval.
