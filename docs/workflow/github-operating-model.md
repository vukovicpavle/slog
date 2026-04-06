# GitHub operating model

GitHub is the workflow system of record for this template. The agent should shape work into GitHub artifacts instead of keeping planning state in hidden memory.

## Canonical artifacts

| Artifact | Purpose | Owner while planning |
| --- | --- | --- |
| Project Brief issue | canonical intake and baseline for a project | workflow-orchestrator |
| Adoption Brief issue | canonical current-state and migration plan for an existing repo | workflow-orchestrator |
| Epic issue | major capability slice under a project | workflow-orchestrator |
| Feature issue | user-visible feature under an epic or project | workflow-orchestrator |
| Task or sub-issue | implementation unit created after feature readiness | workflow-orchestrator before handoff, humans after assignment |
| Milestone | delivery increment for a related set of issues | workflow-orchestrator |
| GitHub Project item | source of truth for mutable state | workflow-orchestrator |
| Pull request | delivery artifact linked back to GitHub work | human assignee |

## Field model

Use GitHub Project fields for mutable workflow state:

| Field | Options | Why it is a field |
| --- | --- | --- |
| Status | intake, clarifying, awaiting-decision, planned, ready-for-assignment, in-progress, in-review, done, blocked | changes often |
| Readiness | missing-basics, draft, ready | changes often |
| Mode | greenfield, adoption | important for routing |
| Priority | high, medium, low | sortable planning signal |
| Risk | high, medium, low | sortable planning signal |

Use labels for stable classification:

- `type/*`
- `area/*`
- `risk/*`
- `mode/*`

Do not use labels as the primary mutable workflow state when project fields are available.

## Relationship rules

- Project Brief -> Epic -> Feature -> Task
- Use explicit dependency links for blocked work
- Pull requests must reference the feature or task they advance
- Milestones group delivery increments, not arbitrary dates

## Milestone pattern

Default milestone sequence:

1. `M0 - Discovery and decisions`
2. `M1 - Foundation and setup`
3. `M2 - Core MVP workflows`
4. `M3 - Polish, QA, docs`
5. `M4 - Release and launch`

The agent may tailor names, but should keep the sequence meaningful and explain why a milestone exists.

## Required views

Recommended GitHub Project views:

- **Intake:** new project or feature requests
- **Planning:** items still clarifying or awaiting decisions
- **Ready for Assignment:** work that passed readiness
- **In Progress:** human-assigned delivery work
- **Blocked:** items with unresolved dependencies
- **Done:** completed work for milestone and release review

The local operations layer can bootstrap Project fields. Recommended views remain documented here and should be created manually to match team needs.

## Mutation policy

The agent may create or update planning artifacts while clarifying work.

The agent may not:

- create implementation issues before readiness
- mass-edit a live backlog during adoption without approval
- silently change the workflow taxonomy

## Repo-side artifacts

Store durable narrative artifacts in the repository when they need versioning or review:

- `docs/projects/<slug>/brief.md`
- `docs/projects/<slug>/adoption.md`
- `docs/features/<slug>.md`
- architecture notes or ADRs linked from GitHub work

These docs support GitHub artifacts; they do not replace them.
