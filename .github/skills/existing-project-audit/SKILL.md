---
name: existing-project-audit
description: Audit an existing repository and GitHub workflow before adoption. Use when the team wants to apply this workflow to a live project instead of starting from zero.
---

Use this skill for **adoption mode**.

## Goal

Create an adoption brief that explains the current state, the gaps against the target model, and a safe path to migrate without rewriting history blindly.

## Required outputs

- Current-state summary
- GitHub inventory: issues, labels, milestones, board usage, PR conventions
- Mapping proposal from the current workflow to `config/workflow-model.yml`
- Recommended adoption mode: Observe, Assist, or Standardize
- Migration scope and guardrails
- Open questions and risks

## Process

1. Confirm this is an existing-project adoption request.
2. Inventory the current repo and GitHub workflow before proposing changes.
3. Separate **active work** from historical closed work.
4. Map current states and labels to the target model instead of forcing a rewrite immediately.
5. Recommend **Assist** by default unless the user explicitly wants stronger migration.
6. Ask for approval before broad changes.

## Guardrails

- Do not mass-relabel the backlog.
- Do not rebuild the project board without approval.
- Do not delete or rewrite historical issues to fit the new model.
- Focus first on the current milestone and open work.

## Success condition

Adoption is ready only when the current state is understood, the target mapping is approved, and the team agrees on migration scope.
