---
name: project-brief-writer
description: Maintain the canonical project brief as planning evolves. Use when intake, clarification, stack decisions, or milestone planning changes the approved narrative of the project.
---

Use this skill whenever the project brief needs to be created, updated, or normalized after a planning conversation.

## Goal

Keep one concise, reviewable project brief that separates approved facts from open questions and proposed decisions.

## Required sections

- Problem or goal
- Target users
- MVP scope
- Out of scope
- Platform
- UI/UX direction
- Approved stack or stack decision status
- Constraints and integrations
- Success criteria
- Milestones summary
- Open questions

## Writing rules

- Preserve the user's language when it captures intent well.
- Mark inferred content as **proposed** until approved.
- Keep the brief readable by product and engineering stakeholders.
- Keep UI/UX direction high-level: tone, feel, and interaction principles, not screen-by-screen layouts.
- Prefer short bullets or tight paragraphs over long narrative.
- Remove stale ambiguity after a decision is approved.

## Update rules

- If a new decision changes scope, update the relevant section and note the impact on milestones or dependencies.
- If a question is still unresolved, keep it in **Open questions** rather than silently dropping it.
- If the project is in adoption mode, do not use this skill; use the adoption brief flow instead.

## Guardrails

- Do not invent product requirements.
- Do not mark a project ready inside the brief itself.
- Do not store workflow state here that belongs in GitHub fields.
