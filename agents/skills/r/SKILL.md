---
name: r
description: Remind the user what they still had to do. No argument = the last step you asked the user to do (usually a command to run); any text = a hint about which step or why they're asking. Use only when the user invokes /r.
argument-hint: "[hint about the step]"
disable-model-invocation: true
---

# Remind me

`/r` means "I asked other questions in between and lost track: what was I supposed to do?". It is a question, not a go-ahead: answer only, change nothing and run nothing.

Hint from the user (may be empty): `$ARGUMENTS`

## What to remind

- **Empty**: the last step you asked the user to do themselves that they haven't confirmed as done. Look back past the side questions to find it: usually a command to run, sometimes a check, an edit or a choice to make.
- **Text**: use it to find the right step (e.g. "the db one", "before the deploy") or to see why they're asking (e.g. "it failed", "I'm back from a break"), and answer with that in mind.
- If the step depends on something that changed since (a newer answer replaced the command, a path was fixed), give the current version and say in one line what changed.
- If there are several pending steps, list them in order and mark the next one.
- If you can't find any pending step, say so in one line and stop.

## Output

- One line: what the step is for.
- Commands in a fenced block, exactly as the user should run them, ready to copy (with the folder to run them from if it matters).
- One line on what to look for afterwards or what comes next, only if it was said.
- No recap of the side questions, no preamble, no closing summary.
