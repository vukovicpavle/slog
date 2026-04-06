---
name: workflow-mapper
description: Map an existing repository's workflow taxonomy to the target GitHub-native model. Use during adoption after the current state has been inventoried.
---

Use this skill once the current GitHub workflow is known and the next step is reconciliation.

## Goal

Show how the current labels, statuses, milestones, and issue relationships map to the target operating model without forcing an immediate rewrite.

## Required outputs

- Mapping table from current states to target states
- Gaps that need new fields, labels, or templates
- Conflicts that need explicit approval
- Recommendation for Observe, Assist, or Standardize

## Process

1. Read `config/workflow-model.yml`.
2. Compare the current repo's taxonomy to the target model.
3. Prefer migration by mapping where possible rather than replacement.
4. Distinguish between stable classification and mutable workflow state.

## Guardrails

- Do not silently discard existing conventions.
- Do not recommend broad change unless the benefit is clear.
- If the current system already solves a target need, map it instead of replacing it.
