---
name: milestone-planner
description: Propose a milestone sequence for a project once the baseline is mostly clear. Use when the team needs a delivery structure before creating epics and features.
---

Use this skill after the project brief is mostly defined and the team is ready to sequence delivery.

## Goal

Produce a milestone plan that reflects delivery increments rather than arbitrary dates.

## Default sequence

Start from this shape and adapt only when the product clearly needs something else:

1. Discovery and decisions
2. Foundation and setup
3. Core MVP workflows
4. Polish, QA, docs
5. Release and launch

## Process

1. Base milestones on the approved MVP scope, not on implementation details.
2. Keep milestones outcome-oriented.
3. Call out dependencies that must land before later milestones.
4. Prefer a small number of meaningful milestones over many thin ones.
5. Ask for confirmation before creating milestones in GitHub.

## Output contract

Return:

- milestone name
- objective
- likely issue types inside it
- gating dependency, if any

## Guardrails

- Do not create milestones before the project baseline is mostly defined.
- Do not overfit milestones to individual developer tasks.
- If the project is too early, say so and ask the next missing planning question instead.
