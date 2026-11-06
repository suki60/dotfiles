---
name: n
description: The user is ready for the next step. Pick the next pending step of the current work (from the plan file or the latest decisions in this conversation) and do it. Use only when the user invokes /n.
argument-hint: "[notes for the next step]"
disable-model-invocation: true
---

# Next step

`/n` means "I'm ready, let's continue with the next thing". It is my go-ahead to act on that step.

Notes from the user (may be empty): `$ARGUMENTS`

## Steps

1. Find the next step:
   - A plan file in use (e.g. `PLAN.md`): the first unchecked step or phase.
   - Otherwise: what the conversation said comes next ("next is …").
   - If unsure which step is next, ask in one line and stop.
2. Say in one line which step you're starting.
3. Do it the usual way, following the notes above if given. If the step needs a choice that's mine to make (content, visuals, what to drop), show the options with a recommendation and wait.
4. Finish as any finished step does: what changed, the checks you ran, and a suggested commit message.
