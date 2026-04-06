---
name: milestone-manager
description: Bootstrap or apply workflow milestones from the model. Use when a repository needs the default milestone sequence or when planned work must be attached to the right milestone.
---

Use this skill to keep delivery increments consistent.

## Preferred commands

Bootstrap the default milestone set:

```bash
scripts/github_workflow.rb bootstrap --repo owner/repo --milestones
```

Attach a new or updated issue spec to a milestone:

```bash
scripts/github_workflow.rb issue apply --repo owner/repo --spec path/to/spec.json
```

## Rules

- Use the milestone sequence in `config/workflow-model.yml`.
- Keep milestone names outcome-oriented.
- Create milestones before attaching issues to them.
- If milestone naming needs to change materially, update the workflow model first.

## Guardrails

- Do not create milestone sprawl.
- Do not attach planning work to a milestone that implies delivery readiness if the item is still clarifying.
- Do not use milestones as a substitute for Project field state.
