---
name: p
description: Write a PLAN.md in the current project with the plan discussed in this conversation. No argument = the plan as agreed so far; any text = what the plan should cover or focus on. Use only when the user invokes /p.
argument-hint: "[what the plan should cover]"
disable-model-invocation: true
---

# Write the plan

`/p` is the go-ahead to write one file: `PLAN.md` at the root of the current project (the git root, or the working directory outside a repo). Change nothing else and run nothing that changes anything.

## What to plan

Arguments: `$ARGUMENTS`

- **Empty**: the plan as it stands from the latest decisions in this conversation.
- **Text**: my description of what the plan should cover. Treat it as the spec: it decides the scope and focus, and wins if it conflicts with your reading of the conversation. Use the conversation to fill in the details it leaves out (paths, values, decisions).

If there's no argument and nothing plan-like in the conversation (no goal, decisions or steps), say so in one line and stop; don't write a thin plan.

If `PLAN.md` already exists, read it first. If it's about the same work, update it (keep what still holds, mark done steps); if it's about something else, ask before replacing it.

## What goes in the file

Review the whole conversation, then write the plan for someone (me later, or a new chat) who wasn't there. Skip any section that would be empty.

```markdown
# <Short title>

## Goal
<one or two sentences: what we want and why>

## Context
- <findings, constraints, current state>
- <exact file paths, commands, names, versions>

## Decisions
- <choice made> — <why, in a few words>

## Steps
1. [ ] <concrete step: the file and the change>
2. [ ] <...>

## Done when
- <how to check the result: command to run and what to look for>

## Open questions
- <only things still undecided>
```

## Rules

- **Self-contained**: no "as discussed" or "the approach above". Name files by path and include exact snippets, keys and values.
- **Only what was discussed**: don't invent steps or decisions. If a gap matters, put it under Open questions.
- **Respect who runs what**: steps I run myself (installs, deploys, data changes) say so, e.g. "(me) run `brew install …`".
- **Visual when it helps**: if the plan involves a flow or structure, add an ASCII diagram in a fenced block, drawn as my `/v` skill describes.
- **Tight**: as short as possible while still complete.

## Output

- After writing, one line with the file path and whether it was created or updated, plus the open questions if any. Don't repeat the plan.
