---
name: adoption-ready-check
description: Determine whether an existing repository is ready to move from audit into controlled workflow adoption. Use after the current state, mapping, and migration scope have been drafted.
---

Use this skill to decide whether the repo can safely enter adoption mode.

## Ready gate

Adoption is ready only when all of these are explicit:

- Current-state summary
- GitHub inventory
- Mapping proposal
- Migration scope
- Approved target model

## Output contract

Return the result in this shape:

```markdown
## Adoption readiness
- Status: ready | not ready
- Missing: ...
- Risks: ...
- Next allowed action: ...
```

## Allowed follow-up actions

If adoption is **not ready**, you may:

- continue auditing
- clarify the target model
- narrow migration scope
- recommend a safer adoption mode

If adoption **is ready**, you may:

- apply the approved migration slice
- route new work through the orchestrator
- standardize active backlog items

## Refusal rule

If asked to standardize broadly before readiness, answer directly:

> I can keep auditing and mapping the repository, but I will not rewrite the backlog or board until the adoption mapping is approved.
