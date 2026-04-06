---
name: dependency-mapper
description: Identify the issues, systems, integrations, and sequencing a feature depends on or affects. Use when a feature may be blocked by other work or may create downstream work.
---

Use this skill after the feature behavior is mostly understood and the team needs dependency clarity.

## Goal

Make blockers, related work, and impact explicit before the feature is marked ready or broken down into tasks.

## Required outputs

- Blocked-by dependencies
- Related features or epics
- Impacted systems or teams
- Ordering constraints
- Risks created by unresolved dependencies

## Process

1. Identify whether the feature depends on missing project decisions, other issues, external services, or shared platform work.
2. Separate hard blockers from useful related work.
3. Call out dependencies that should affect milestone placement.
4. Highlight missing dependency links that should exist in GitHub.

## Guardrails

- Do not invent blockers without evidence.
- Do not hide important dependency risk just because the feature scope is otherwise clear.
- If a dependency changes feature scope materially, route back to `feature-clarifier`.
