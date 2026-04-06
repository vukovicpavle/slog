---
name: artifact-sync
description: Sync durable repo-side planning docs from a structured spec. Use when a project brief, adoption brief, or feature spec should exist in the repository alongside its GitHub issue.
---

Use this skill when planning information needs a versioned markdown artifact in the repository.

## Preferred commands

Sync the artifact only:

```bash
scripts/github_workflow.rb artifact sync --spec path/to/spec.json
```

Or sync issue plus artifact in one step:

```bash
scripts/github_workflow.rb issue apply --repo owner/repo --spec path/to/spec.json
```

## Rules

- Use the artifact path patterns from `config/workflow-model.yml`.
- Keep GitHub as the source of truth for workflow state.
- Use repo docs for durable narrative artifacts only.
- Reuse the same spec file for issue creation and doc sync when possible.

## Guardrails

- Do not create duplicate planning docs for the same artifact.
- Do not let repo docs drift from the issue spec.
- Do not store mutable board state in repo docs.
