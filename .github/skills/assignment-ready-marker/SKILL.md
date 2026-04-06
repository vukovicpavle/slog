---
name: assignment-ready-marker
description: Mark a feature or task ready for human assignment after the ready gate and supporting links are complete. Use when planning work is fully shaped and should hand off from the planner to a person.
---

Use this skill after `feature-ready-check` returns `ready` and the GitHub artifact is fully aligned.

## Goal

Move work from planning into the explicit human handoff state without unlocking it too early.

## Preferred command

```bash
scripts/github_workflow.rb project sync-item \
  --repo owner/repo \
  --project-owner owner \
  --project-number 1 \
  --issue-number 42 \
  --field Status=ready-for-assignment \
  --field Readiness=ready
```

## Required checks

Before marking ready for assignment, confirm:

- the relevant ready gate passed
- the parent issue is linked
- the milestone is set
- Project fields are synced
- native relationships are synced if needed
- the durable planning artifact is synced if needed

## Guardrails

- Do not mark ready for assignment if acceptance criteria are still fuzzy.
- Do not mark ready for assignment if key dependencies are unresolved.
- Do not skip the Project field update; GitHub state is the handoff signal.
