---
name: feature-clarifier
description: Close the most important gaps in a draft feature spec one question at a time. Use after feature intake when the feature exists but the feature ready gate still has missing basics.
---

Use this skill after a feature request has been captured and the next job is to reduce ambiguity without drifting into implementation.

## Goal

Move a feature from rough request to decision-ready spec with the fewest necessary questions.

## Process

1. Read the current feature draft.
2. Identify the single highest-risk missing item.
3. Ask one focused question that unlocks the next planning step.
4. If the feature changes UI, clarify entry point, placement, primary states, and copy before downstream implementation impact.
5. Update the spec after each answer before asking the next question.
6. Route acceptance-criteria shaping to `acceptance-criteria-builder` when needed.
7. Route cross-issue or system relationships to `dependency-mapper`.

## Prioritization order

Use this order unless a later gap is clearly riskier:

1. Linked project or epic
2. User outcome
3. Main flow
4. Detailed UI/UX direction
5. Acceptance criteria
6. Edge cases
7. Dependencies
8. Technical impact
9. Test impact
10. Docs or rollout impact

## Guardrails

- Do not ask compound questions.
- Do not jump to implementation details before the user-visible behavior is clear.
- Do not accept vague UI language such as "add a button" without saying where it appears and how it behaves.
- Do not declare the feature ready; route that decision to `feature-ready-check`.
