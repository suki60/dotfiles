---
name: h
description: Hand off the pending work from this conversation to a new chat. Outputs one copyable block written as a direct request and copies it to the clipboard, so pasting it into the next chat starts the work right away without more explaining. Use only when the user invokes /h.
disable-model-invocation: true
---

# Hand off to the next chat

Write a prompt the user pastes into a fresh chat. That chat knows nothing about this one, so the prompt has to carry everything it needs to act now.

## What to hand off

Arguments: the text I typed after the command, if any.

- **Empty**: hand off the work that is still pending, as you understand it from the latest decisions in this conversation.
- **Text**: this is my description of what to hand off. Treat it as the spec: it decides the task and its scope, and wins if it conflicts with your reading of the conversation. Use the conversation only to fill in the details it leaves out (paths, values, checks, decisions). It may also say where the next chat will run (e.g. "the starship change, from the dotfiles repo").

## What goes in the block

Review the whole conversation, then write it as a request from the user, in the first person ("I want…", "Please…"), not as a summary of a chat. Skip any section that would be empty.

```
TASK
<one or two sentences: what to do, as a direct request>

CONTEXT
- <facts the next chat needs: findings, causes, why this change>
- <exact file paths, commands, names, versions, values found>

ALREADY DONE / RULED OUT
- <checks or attempts that already happened, so they aren't repeated>

DECISIONS
- <choices the user already made; don't reopen them>

STEPS
1. <concrete step, with the file and the change>
2. <...>

DONE WHEN
- <how to check the result: command to run and what to look for>

OPEN QUESTIONS
- <only things still undecided; ask me these before acting>
```

## Rules

- **Self-contained**: no "as discussed", "the file above" or "that approach". Name every file by its full path, and include exact snippets, config keys and values.
- **Actionable**: open with the request. Make the steps specific enough that the next chat can start at step 1 without asking anything, unless an item is truly in OPEN QUESTIONS.
- **Paste counts as the go-ahead**: my global rules ask the agent to wait for an explicit request before editing. Word the TASK as that request, e.g. "Please make these changes", so the next chat doesn't stop to ask.
- **Respect who runs what**: if the user runs commands themselves (builds, data changes, restarts), list those steps as "give me the command to run", not as something the next chat runs.
- **Leave out**: chat history, dead ends that don't matter, and this chat's temporary files, unless the next chat needs them.
- **Tight**: as short as possible while still complete.

## Output

- Put the whole handoff in one fenced block with a 4-backtick fence (````` ````text `````), so code snippets inside it can use normal triple-backtick fences without breaking it.
- Inside the block, use plain text with ALL-CAPS section titles, no `#` headers.
- Also copy the handoff to the clipboard, so the user only presses ⌘V: write the block's content (without the fence) to a temp file in `/tmp`, then run `pbcopy < <that file>`. A file avoids quoting problems with multi-line text. If `pbcopy` isn't available, skip this step.
- After the block, write at most one line, e.g. which folder or repo to open the new chat in, plus "(copied)" if the clipboard step ran. Don't repeat the content.
- Don't create files other than that temp file; the block is the whole output.
