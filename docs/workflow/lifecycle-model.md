# Lifecycle model

This template treats planning as two nested lifecycles:

1. **Project lifecycle** for shaping the delivery system and backlog
2. **Feature lifecycle** for shaping one unit of work inside that system

The two project entry paths are:

- **Greenfield:** the team is starting a new product or initiative
- **Adoption:** the team is applying this workflow to an existing repository

## Core principle

The agent is allowed to help early, but not allowed to unlock execution early.

Before readiness, the agent may:

- capture intent
- clarify ambiguity
- propose defaults
- update long-form planning artifacts
- capture UI/UX direction at the right planning level
- recommend stack and milestones

Before readiness, the agent may not:

- generate executable implementation tasks
- mark work ready for assignment
- start coding or delivery work

## Project lifecycle

### Greenfield flow

| Stage | Goal | Typical output |
| --- | --- | --- |
| idea | capture the rough product idea | initial problem statement |
| intake | structure the request | draft project brief |
| clarifying | close missing basics | filled baseline fields |
| stack and constraints | agree on implementation direction | approved stack recommendation |
| milestone proposal | sequence the work | milestone draft |
| ready | unlock issue creation | approved project baseline |

### Adoption flow

| Stage | Goal | Typical output |
| --- | --- | --- |
| audit | understand current repo and workflow | current-state summary |
| reconcile | compare current state to target model | mapping proposal |
| baseline | agree migration scope and conventions | adoption brief |
| adoption ready | allow incremental standardization | approved migration plan |

### Project ready gate

The project is only ready when all of the following exist:

- problem or goal
- target users
- MVP scope
- out of scope
- platform
- high-level UI/UX direction
- approved stack
- key constraints
- milestone plan
- success criteria

For user-facing products, this direction should describe the intended tone, visual feel, or interaction posture. For non-user-facing work, the brief should say that explicitly.

If any item is missing, the agent should say what is missing and offer the next clarifying step instead of creating issues.

## Feature lifecycle

| Stage | Goal | Typical output |
| --- | --- | --- |
| request | capture the feature request | feature draft |
| clarify | resolve scope and behavior | clarified intent |
| spec | define the user-visible behavior | feature spec |
| dependencies | map system and backlog impact | dependency map |
| ready | confirm definition of ready | ready-check result |
| breakdown | create child work | implementation task draft |
| ready for assignment | hand off to humans | ready issue or sub-issues |

### Feature ready gate

The feature is only ready when all of the following exist:

- linked project or epic
- user outcome
- acceptance criteria
- main flow
- detailed UI/UX direction
- edge cases
- dependencies
- technical impact
- test impact
- docs or rollout impact

For user-facing features, this should be specific enough to describe entry points, placement, important states, and key interactions. If there is no user-facing UI change, the spec should say that explicitly.

## Delivery closeout

Once a human is assigned, the lifecycle moves into delivery:

| Stage | Purpose |
| --- | --- |
| in progress | work is actively being implemented |
| PR linked | delivery artifact is attached to GitHub work |
| in review | human or agent review is underway |
| done | implementation and acceptance are complete |
| release and retro | milestone and process feedback are captured |

## Human handoff boundary

The planning agent owns work until it reaches `ready-for-assignment`. Humans own assignment and delivery after that point.

## Refusal language

Use direct refusal for disallowed actions:

- **Project not ready:** "I can keep shaping the brief, but I will not create milestones or feature issues until the project baseline is complete."
- **Feature not ready:** "I can keep refining the feature spec, but I will not create implementation tasks or start work until the feature ready gate passes."
- **Adoption not ready:** "I can audit and map the current workflow, but I will not rewrite the backlog or board until the adoption mapping is approved."
