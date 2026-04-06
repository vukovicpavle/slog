---
name: project-ready-check
description: Determine whether a project baseline is ready to unlock milestone, epic, and feature creation. Use after project intake, clarification, stack selection, or milestone planning.
---

Use this skill to decide whether the project lifecycle can move from planning into issue generation.

## Ready gate

The project is ready only when all of these are present and explicit:

- Problem or goal
- Target users
- MVP scope
- Out of scope
- Platform
- High-level UI/UX direction
- Approved stack
- Key constraints
- Milestone plan
- Success criteria

## Output contract

Return the result in this shape:

```markdown
## Project readiness
- Status: ready | not ready
- Missing: ...
- Risks: ...
- Next allowed action: ...
```

## Decision rules

- If any required item is missing, the project is **not ready**.
- If an item exists but is still disputed, treat it as missing.
- If the project has a user-facing surface, the UI/UX direction must describe the intended feel or interaction style. If the project is not user-facing, the brief must say that explicitly.
- If the stack is only proposed and not approved, treat it as missing.
- If milestones do not reflect a meaningful delivery sequence, treat the milestone plan as incomplete.

## Allowed follow-up actions

If the project is **not ready**, you may:

- ask the next missing question
- refine the brief
- clarify UI/UX direction
- invoke `stack-advisor`
- invoke `milestone-planner`

If the project **is ready**, you may:

- offer milestone creation
- offer epic generation
- offer feature issue generation

## Refusal rule

If asked to generate issues before readiness, answer directly:

> I can keep shaping the project, but I will not create milestones or feature issues until the project baseline is complete.
