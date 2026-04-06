---
name: github-state-inventory
description: Inventory the current GitHub workflow surfaces in an existing repository. Use during adoption mode before any broad workflow changes are proposed.
---

Use this skill to build the GitHub-facing portion of an adoption audit.

## Goal

Capture the real current state of the repository's GitHub workflow so adoption decisions are based on evidence.

## Inventory checklist

- issue types in use
- labels and label conventions
- milestones
- project boards and fields
- issue relationships and dependency patterns
- pull request conventions
- templates or forms

## Output format

Use a structured summary:

- Current assets
- Gaps against `config/workflow-model.yml`
- Conflicts that need decisions
- Safe migration opportunities

## Guardrails

- Audit first, mutate later.
- Focus on active workflow surfaces, not every historical artifact.
- Do not assume the repository already matches the target model.
