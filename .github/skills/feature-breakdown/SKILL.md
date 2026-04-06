---
name: feature-breakdown
description: Break a ready feature into child work that a team can assign and deliver. Use only after the feature ready gate passes.
---

Use this skill after `feature-ready-check` returns `ready`.

## Goal

Create a delivery-oriented task breakdown that preserves the feature intent and dependencies.

## Process

1. Confirm the feature is ready.
2. Group child work by outcome and dependency, not by arbitrary technical micro-steps.
3. Keep tasks large enough to be meaningful but small enough to assign.
4. Preserve detailed UI/UX requirements in child work so placement, state, and copy changes remain explicit.
5. Include cross-cutting work such as docs, tests, rollout, or migration when needed.
6. Preserve dependency order between child tasks.

## Recommended breakdown categories

- Product or UX changes
- API or backend work
- Frontend or client work
- Data or integration work
- Testing and observability
- Documentation or rollout work

## Guardrails

- Do not run this skill before the feature is ready.
- Do not assign humans automatically.
- Do not create child tasks that simply restate the parent feature.
- Do not omit docs, rollout, or test work if the feature clearly needs them.
