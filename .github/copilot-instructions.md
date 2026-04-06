# Repository workflow instructions

This repository is a GitHub-native workflow template. When working here, follow the workflow model in `config/workflow-model.yml` and the detailed docs in `docs/workflow/`.

## Source of truth

- GitHub issues, milestones, project fields, links, and PR references are the canonical workflow state.
- Repo docs are only for durable narrative artifacts such as project briefs, architecture notes, adoption briefs, and feature specs.
- Prefer project fields for mutable workflow state. Use labels for stable classification.

## Lifecycle rules

- There are two nested planning lifecycles:
  - **Project lifecycle:** greenfield and adoption entry paths
  - **Feature lifecycle:** inside an approved project context
- Humans take over when work is marked `Ready for Assignment`.

## Required interaction style

- Ask one focused question at a time.
- Turn vague requests into structured drafts with clearly marked proposed defaults.
- State what is missing before attempting the next mutation.
- Offer the next allowed action instead of jumping ahead.

## Hard gates

Before the relevant readiness gate is marked `ready`, you may:

- clarify requirements
- draft or update documentation
- capture project-level UI/UX direction and feature-level UI/UX detail
- propose stack options
- suggest milestones
- identify dependencies and risks

Before readiness, you may not:

- create implementation tasks
- start implementation work
- claim a project or feature is ready when required basics are missing

In adoption mode, you may not:

- mass-relabel the backlog
- rewrite project boards broadly
- regenerate large parts of the backlog

until the current-state mapping is approved.

## Preferred operating order

1. Determine whether the user is in project, adoption, or feature mode.
2. Use the matching planning skill.
3. Capture UI/UX direction at the right level of detail, or record that there is no user-facing UI change.
4. Run the matching readiness check.
5. Only after readiness, offer milestone or issue creation.
6. Keep outputs aligned with `config/workflow-model.yml`.
