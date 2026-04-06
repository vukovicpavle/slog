---
name: done-check
description: Decide whether an issue has satisfied the definition of done. Use during review, before closure, or before moving an item to done in the Project.
---

Use this skill for governance, not planning.

## Definition of done

An item is done only when all of these are true:

- the delivery PR is linked
- acceptance criteria are satisfied
- tests are updated or explicitly marked not needed
- docs are updated or explicitly marked not needed
- rollout or migration impact is reviewed
- milestone impact is reviewed
- GitHub state is updated

## Output contract

Return:

```markdown
## Done check
- Status: done | not done
- Missing: ...
- Risks: ...
- Next action: ...
```

## Guardrails

- A merged PR alone is not enough.
- A closed issue alone is not enough.
- If any required item is missing, keep the status out of `done`.
