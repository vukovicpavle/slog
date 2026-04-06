---
name: pr-link-sync
description: Keep pull requests linked to the correct planning issue. Use when a PR is opened, updated, or reviewed and the issue relationship needs to be explicit in the PR body.
---

Use this skill once delivery work has moved into a pull request.

## Goal

Ensure the PR body points back to the right feature or task so GitHub history stays navigable and closeout automation can work later.

## Process

1. Identify the primary issue the PR advances.
2. Ensure the PR body contains one of:
   - `Closes #123`
   - `Relates to #123`
3. If multiple issues are involved, keep one primary issue and relate the others.
4. Keep the PR aligned with `.github/pull_request_template.md`.

## Guardrails

- Do not leave a PR unlinked to planning work.
- Do not use `Closes` if the PR only partially advances the issue.
- Do not spread ownership by closing multiple unrelated issues from one PR body.
