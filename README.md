# GitHub-native Workflow Starter

This template turns a GitHub repository into a planning front door. A teammate can open Copilot Chat in the repo, describe a product or feature, and the local workflow agent will shape it into GitHub-native work: project briefs, feature specs, milestones, issues, links, and PR expectations.

The template is built around three rules:

1. GitHub is the source of truth for workflow state.
2. Project and feature work follow separate but nested lifecycles.
3. The agent refuses issue generation or implementation until the required baseline is ready.

## Start here

- Workflow model: `config/workflow-model.yml`
- Onboarding: `docs/workflow/getting-started.md`
- Simulation matrix: `docs/workflow/simulation-matrix.md`
- GitHub operations CLI: `docs/workflow/github-operations.md`

## Included foundation

- A public `workflow-orchestrator` custom agent
- Local skills for planning, GitHub operations, and governance across project, feature, adoption, and delivery flows
- A local GitHub operations CLI for labels, milestones, issues, Project fields, native issue links, and doc sync
- A machine-readable workflow model in `config/workflow-model.yml`
- Lifecycle, GitHub operating model, and orchestrator contract docs
- GitHub issue forms and a pull request template aligned to the workflow

## Current lifecycle model

| Lifecycle | Primary path | Ready gate |
| --- | --- | --- |
| Project (greenfield) | idea -> intake -> clarification -> stack and constraints -> milestone proposal -> ready | project baseline complete |
| Project (adoption) | audit -> reconcile -> baseline -> adoption ready | existing workflow mapped and approved |
| Feature | request -> clarify -> spec -> dependencies -> ready -> breakdown -> ready for assignment | feature spec complete |
| Delivery closeout | in progress -> PR linked -> review -> done -> release and retro | definition of done |

## Repository layout

```text
.github/
  agents/
  skills/
  ISSUE_TEMPLATE/
  copilot-instructions.md
config/
  workflow-model.yml
docs/
  workflow/
scripts/
```

## How this is meant to work

1. A teammate opens Copilot Chat in the repository.
2. They describe a new app idea, an existing-project adoption request, or a feature.
3. `workflow-orchestrator` determines the mode and invokes the right local skills.
4. The agent captures or updates the right GitHub artifact, records project-level or feature-level UI/UX direction, and asks one focused question at a time.
5. When the relevant ready gate passes, the agent can offer to create milestones and ready-to-assign work.

## Important constraint

This scaffold intentionally stops before delivery automation. The agent can clarify, document, propose stacks, and shape work now. Later phases will add GitHub mutation automation, governance skills, and end-to-end simulations.
