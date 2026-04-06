---
name: project-intake
description: Turn a rough new-project idea into a structured project brief. Use when a user describes a new app, product, or initiative and the project baseline is not yet established.
---

Use this skill when the user arrives with a vague project idea such as "I want to build an app like this."

## Goal

Capture the request as a draft project brief that is structured enough to drive the rest of the project lifecycle without pretending the project is ready.

## Required outputs

Produce or update a draft project brief with these sections:

- Problem or goal
- Target users
- MVP scope
- Out of scope
- Platform
- UI/UX direction
- Proposed stack status
- Constraints and integrations
- Success criteria
- Open questions

## Process

1. Confirm that this is a **greenfield project** rather than adoption or feature work.
2. Turn the user's words into a short draft brief before asking many questions.
3. Ask one focused question at a time to close the biggest gap.
4. Capture UI/UX direction as product-level tone, visual language, and interaction posture rather than screen-by-screen layout.
5. Prefer proposed defaults over open-ended prompts.
6. Mark inferred values as **proposed** until the user approves them.
7. Once the brief has enough product context, route stack decisions to `stack-advisor`.
8. Once the basics are present, route milestone planning to `milestone-planner`.
9. Run `project-ready-check` before offering issue generation.

## Guardrails

- Do not create epics, features, or tasks yet.
- Do not start implementation.
- Do not force feature-level screen specs into the project brief.
- Do not say the project is ready until `project-ready-check` passes.
- If the user asks for issues too early, explain what is missing and continue clarifying.

## Suggested first-pass brief format

```markdown
# Project brief

## Problem or goal

## Target users

## MVP scope

## Out of scope

## Platform

## UI/UX direction

## Constraints and integrations

## Success criteria

## Open questions
```
