---
name: feature-intake
description: Turn a feature request into a structured feature spec inside an existing project context. Use when a user asks for a new feature or change within an approved project.
---

Use this skill when the user requests a feature such as "Add team invites" or "We need billing export."

## Goal

Produce a feature spec that is clear enough to evaluate readiness and, later, create child work without leaking into implementation too early.

## Required outputs

Capture or update these sections:

- Linked project, epic, or milestone
- User outcome
- Main flow
- Detailed UI/UX direction
- Acceptance criteria
- Edge cases
- Dependencies
- Technical impact
- Test impact
- Docs or rollout impact
- Open questions

## Process

1. Confirm that the request belongs to an existing project context.
2. If the linked project or epic is unknown, ask for or infer the correct parent first.
3. Translate the request into a user-visible outcome.
4. For user-facing changes, capture the exact entry point, placement, states, copy, and key interactions. If there is no user-facing UI change, say that explicitly.
5. Ask one focused question at a time to close the highest-risk ambiguity.
6. Surface system dependencies and integration impact before breakdown.
7. Run `feature-ready-check` before generating child tasks.

## Guardrails

- Do not start implementation.
- Do not create child implementation issues until the feature is ready.
- Do not leave UI work at "add a button" level; say where it lives and how it behaves.
- Do not ignore docs, rollout, or test impact.
- If the project context is missing, route back to the project lifecycle instead of pretending the feature stands alone.

## Suggested first-pass spec format

```markdown
# Feature spec

## Linked project or epic

## User outcome

## Main flow

## Detailed UI/UX direction

## Acceptance criteria

## Edge cases

## Dependencies

## Technical impact

## Test impact

## Docs or rollout impact

## Open questions
```
