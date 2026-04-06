---
name: acceptance-criteria-builder
description: Turn a feature request into clear, testable acceptance criteria. Use when a feature outcome is understood but the pass conditions are still fuzzy or incomplete.
---

Use this skill when the feature needs concrete pass conditions before it can be marked ready.

## Goal

Produce acceptance criteria that are specific enough for planning, testing, and review.

## Process

1. Start from the user outcome and main flow.
2. Convert vague expectations into observable pass conditions.
3. Include the happy path and meaningful failure or edge cases.
4. If the feature changes UI, include observable criteria for entry point, placement, primary states, and key error or empty states.
5. Keep criteria user-visible where possible.
6. Add technical criteria only when they affect correctness, rollout, or operability.

## Output style

Use numbered acceptance criteria. Each item should be verifiable.

Example shape:

1. When ...
2. If ...
3. The system should ...

## Guardrails

- Do not mix implementation tasks into acceptance criteria.
- Do not use vague language like "works well" or "is user-friendly" without concrete meaning.
- If detailed UI/UX direction is missing for a user-facing change, route back to `feature-clarifier`.
- If the user outcome itself is unclear, route back to `feature-clarifier`.
