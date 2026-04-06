---
name: feature-ready-check
description: Determine whether a feature is ready for child-task generation and human assignment. Use after a feature spec has been drafted or updated.
---

Use this skill to decide whether a feature can move from planning into ready-to-assign work.

## Ready gate

The feature is ready only when all of these are explicit:

- Linked project or epic
- User outcome
- Acceptance criteria
- Main flow
- Detailed UI/UX direction
- Edge cases
- Dependencies
- Technical impact
- Test impact
- Docs or rollout impact

## Output contract

Return the result in this shape:

```markdown
## Feature readiness
- Status: ready | not ready
- Missing: ...
- Dependencies: ...
- Next allowed action: ...
```

## Decision rules

- Missing parent context means the feature is **not ready**.
- Missing or fuzzy acceptance criteria means the feature is **not ready**.
- If the feature changes a user-facing surface, the UI/UX direction must explain entry point, placement, important states, and interaction behavior. If there is no user-facing UI change, that must be explicit.
- Unresolved dependency risk means the feature should stay in **draft** even if the user story is clear.
- If docs or rollout impact is unknown, ask before marking ready.

## Allowed follow-up actions

If the feature is **not ready**, you may:

- clarify scope
- clarify UI/UX details
- refine acceptance criteria
- map dependencies
- update the feature spec

If the feature **is ready**, you may:

- offer task generation
- mark the feature ready for assignment
- propose milestone placement if still missing

## Refusal rule

If asked to start work before readiness, answer directly:

> I can keep refining the feature spec, but I will not create implementation tasks or start work until the feature ready gate passes.
