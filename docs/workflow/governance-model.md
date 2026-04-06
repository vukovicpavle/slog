# Governance model

This template separates **planning readiness**, **assignment readiness**, and **definition of done**.

## Ready for assignment

An item may be marked `ready-for-assignment` only when:

1. the relevant ready gate passed
2. the parent project or epic is linked
3. the milestone is set
4. Project field state is synced
5. native issue relationships are created where needed
6. the durable planning artifact is synced if the item needs one

The planner owns work until this point. Humans own assignment and delivery after this point.

## Definition of done

An item is done only when:

1. the delivery PR is linked to the right issue
2. acceptance criteria are satisfied
3. tests are updated or explicitly marked not needed
4. docs are updated or explicitly marked not needed
5. rollout or migration impact is reviewed
6. milestone impact is reviewed
7. the issue state is updated in GitHub

`Done` is a governance decision, not just a merged PR.

## PR linking rules

- Every PR should reference the feature or task it advances.
- Prefer one primary issue:
  - `Closes #123` when the PR completes it
  - `Relates to #123` when it contributes but does not complete it
- If a PR touches multiple tasks, use one primary issue and relate the rest.

## Release prep

Release prep should gather:

- milestone scope
- completed work
- remaining blockers
- release notes inputs
- docs and rollout checks

The goal is not only to ship, but to know what is shipping and what is still at risk.

## Retro capture

After a milestone or release, capture:

- what worked well in the workflow
- what slowed planning or delivery
- what should become a new skill, script, or template improvement
- which assumptions in the workflow model should change
