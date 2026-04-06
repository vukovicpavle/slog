# Simulation matrix

This matrix pressure-tests the template against the core flows it is expected to handle.

## Scenario 1: Greenfield product idea

**Prompt:** "I want to build a collaboration app for small software teams."

| Item | Expected result |
| --- | --- |
| Mode | Project / greenfield |
| Skills | `project-intake` -> `project-clarifier` -> `project-brief-writer` -> `stack-advisor` -> `milestone-planner` -> `project-ready-check` |
| Blocked actions | No epics, features, or implementation issues before project readiness |
| Expected artifacts | Project Brief issue and doc with high-level UI/UX direction, proposed milestones |
| Example spec | `docs/workflow/examples/project-brief-team-collab.json` |

## Scenario 2: Existing-repo adoption

**Prompt:** "We want to add this workflow to our current analytics repo."

| Item | Expected result |
| --- | --- |
| Mode | Project / adoption |
| Skills | `existing-project-audit` -> `github-state-inventory` -> `workflow-mapper` -> `docs-reconciler` -> `adoption-ready-check` |
| Blocked actions | No broad backlog rewrite before mapping approval |
| Expected artifacts | Adoption Brief issue, adoption brief doc, recommended adoption mode |
| Example spec | `docs/workflow/examples/adoption-existing-repo.json` |

## Scenario 3: Feature planning in an approved project

**Prompt:** "Add team invites."

| Item | Expected result |
| --- | --- |
| Mode | Feature |
| Skills | `feature-intake` -> `feature-clarifier` -> `acceptance-criteria-builder` -> `dependency-mapper` -> `feature-ready-check` |
| Blocked actions | No child tasks before feature readiness |
| Expected artifacts | Feature issue and doc with detailed UI/UX direction, milestone placement |
| Example spec | `docs/workflow/examples/feature-team-invites.json` |

## Scenario 4: Blocked feature with explicit dependency

**Prompt:** "Plan export reporting, but it depends on the billing data model work."

| Item | Expected result |
| --- | --- |
| Mode | Feature |
| Skills | `feature-intake` -> `dependency-mapper` -> `feature-ready-check` -> `issue-link-manager` |
| Blocked actions | No ready-for-assignment state while a hard blocker is unresolved |
| Expected artifacts | Feature issue linked with native `blocked by` dependency |
| Example pattern | `relationships.blocked_by` in `docs/workflow/examples/feature-team-invites.json` |

## Scenario 5: Assignment, delivery, and release closeout

**Prompt:** "Mark this ready for assignment" or "Is milestone M3 ready to release?"

| Item | Expected result |
| --- | --- |
| Mode | Governance / delivery closeout |
| Skills | `assignment-ready-marker` -> `pr-link-sync` -> `done-check` -> `release-prep` -> `retro-capture` |
| Blocked actions | No `done` or release-ready decision without governance checks |
| Expected artifacts | Project field updates, linked PRs, release readiness summary, retro notes |
| Source docs | `docs/workflow/governance-model.md` |

## Hardened decisions from the simulation

1. **One public agent is still the right default.** The skill routing is the complexity boundary, not the user interface.
2. **GitHub Project fields should be bootstrapped early.** The board is the state machine, not a report.
3. **Adoption mode needs an explicit safe default.** `Assist` is the least risky starting point for live repositories.
4. **Feature readiness must include dependency visibility.** Without native `blocked by` links, assignment signals are too optimistic.
5. **UI/UX direction must exist at two levels.** Project briefs need high-level experience direction, while feature specs need exact screen and interaction detail.
6. **Definition of done needs its own layer.** Planning readiness and delivery completion are different decisions and must stay separate.
