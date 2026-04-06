---
name: architecture-outline
description: Propose a high-level architecture outline once the project brief and stack are mostly stable. Use when the team needs a shared implementation shape before breaking work into epics and features.
---

Use this skill after the product direction and preferred stack are sufficiently clear.

## Goal

Produce a lightweight architecture outline that helps with planning and dependency discovery without overdesigning the solution.

## Required outputs

- Primary components or subsystems
- Major user or system workflows
- Data boundaries
- External integrations
- Cross-cutting concerns
- Risks or decision hotspots

## Process

1. Read the current project brief.
2. Confirm the platform and stack are stable enough to reason about architecture.
3. Describe the system at a planning level, not an implementation detail level.
4. Highlight areas that will likely become epics, shared services, or cross-cutting tasks.
5. Point back to unresolved architectural questions if they block planning.

## Guardrails

- Do not design internals for components that do not yet need to exist.
- Do not create pseudo-implementation tasks.
- Do not turn the outline into an ADR if the decision is still open.
- If the stack is still undecided, ask for that decision before using this skill.
