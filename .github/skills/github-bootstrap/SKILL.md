---
name: github-bootstrap
description: Establish or reconcile the repository's GitHub workflow configuration using the template's workflow model. Use when setting up or standardizing issues, templates, labels, milestones, and project fields.
---

Use this skill when the repository needs its GitHub workflow surfaces aligned with `config/workflow-model.yml`.

## Goal

Apply the operating model consistently across repository-visible GitHub features.

## Scope

This skill covers:

- issue forms
- pull request template
- label taxonomy
- project fields and recommended views
- milestone naming
- link conventions

## Process

1. Read `config/workflow-model.yml`.
2. Use issue forms and PR templates in `.github/` as the repo-visible contract.
3. Run the local bootstrap command to sync labels, milestones, and Project fields:

   ```bash
   scripts/github_workflow.rb bootstrap \
     --repo owner/repo \
     --project-owner owner \
     --project-number 1
   ```

4. Treat labels as stable classification and project fields as mutable workflow state.
5. In adoption mode, prefer reconciliation over replacement.
6. Explain any mismatch between the current repo and the target model before broad changes.

## Guardrails

- Do not invent a second workflow model.
- Do not use labels as the primary source of workflow state if project fields are available.
- Do not perform destructive cleanup without explicit approval.
