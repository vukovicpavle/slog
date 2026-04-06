---
name: incremental-migration
description: Apply workflow adoption in controlled phases instead of a repo-wide rewrite. Use after adoption readiness passes and the team wants a safe migration plan.
---

Use this skill after `adoption-ready-check` returns `ready`.

## Goal

Standardize the workflow in slices that minimize disruption to active delivery.

## Migration order

Prefer this order unless the repo context demands otherwise:

1. New incoming work
2. Active milestone
3. Open issues with clear ownership
4. Shared templates and conventions
5. Older open backlog items

## Output contract

Return:

- migration phase
- target scope
- expected GitHub changes
- rollback or pause point

## Guardrails

- Do not attempt a repo-wide rewrite in one step.
- Do not touch closed history unless there is a strong reason.
- Keep human approval boundaries explicit at each phase.
