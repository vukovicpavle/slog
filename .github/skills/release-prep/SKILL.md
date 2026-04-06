---
name: release-prep
description: Gather milestone scope, completed work, blockers, and release-note inputs before a release or launch. Use when a milestone is nearing completion or the team wants a release readiness summary.
---

Use this skill near the end of a milestone or before a launch decision.

## Goal

Create a release readiness view that shows what is shipping, what is still blocked, and what needs attention before release.

## Gather

- milestone scope
- completed issues and PRs
- open blockers
- release notes inputs
- docs and rollout checks

## Suggested GitHub queries

Use GitHub issues, milestones, and PRs as the data source. Prefer milestone-scoped views first, then inspect blockers and linked PRs.

## Output contract

Return:

```markdown
## Release readiness
- Milestone: ...
- Ready: yes | no
- Shipping: ...
- Blockers: ...
- Docs and rollout: ...
- Next action: ...
```

## Guardrails

- Do not declare a release ready if blockers remain unresolved.
- Do not skip docs or rollout checks just because implementation is done.
- Keep the summary milestone-scoped, not repository-wide.
