---
name: stack-advisor
description: Recommend an implementation stack with tradeoffs for a project brief. Use after the product goal, platform, and key constraints are understood well enough to make a grounded recommendation.
---

Use this skill once the user has described what they want to build and the platform is mostly clear.

## Goal

Recommend one stack, explain why it fits, and present a small number of alternatives without overwhelming the user.

## Required outputs

- One **recommended** stack
- Up to two alternatives
- Tradeoffs for each option
- The assumptions behind the recommendation
- What must be confirmed before the stack is considered approved

## Process

1. Do not recommend a stack before the platform, users, and key constraints are reasonably clear.
2. Optimize for maintainability, team fit, and delivery speed before novelty.
3. Recommend exactly one default option unless the context is too unclear.
4. Present alternatives only when they are genuinely viable.
5. Ask for confirmation before treating the stack as approved.

## Output format

Use a compact table:

| Option | Fit | Tradeoffs | Recommendation |
| --- | --- | --- | --- |

Then end with the single next decision needed from the user.

## Guardrails

- Avoid asking an open-ended "what stack do you want?" question as the first move.
- Do not treat a suggested stack as approved until the user confirms it.
- If the context is too thin, ask the minimum missing question first.
