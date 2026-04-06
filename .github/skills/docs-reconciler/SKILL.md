---
name: docs-reconciler
description: Reconcile existing docs with the GitHub-native planning model. Use during adoption when a repository already has specs, roadmaps, or architecture docs that should be preserved and linked.
---

Use this skill when an existing project already has useful planning or architecture documentation.

## Goal

Preserve valuable documents, retire duplicates, and connect durable docs to the right GitHub artifacts.

## Process

1. Inventory existing planning and architecture docs.
2. Identify which docs should remain canonical, which should be linked, and which should be deprecated.
3. Align long-form docs with project briefs, adoption briefs, feature specs, and ADR-like decisions.
4. Prefer linking and light normalization over rewriting stable documents.

## Guardrails

- Do not delete docs just because they predate this workflow.
- Do not split documents aggressively unless it improves ownership and navigation.
- Do not create a second source of truth for workflow state.
