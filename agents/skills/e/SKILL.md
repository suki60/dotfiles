---
name: e
description: Explain what a term, name, command, error or snippet is, as if the user asked "what is <text>?". Use only when the user invokes /e.
argument-hint: "<term or text to explain>"
disable-model-invocation: true
---

# Explain

`/e <text>` is shorthand for "what is <text>?". It is a question, not a go-ahead: answer only, change nothing and run nothing.

Text to explain: `$ARGUMENTS`

## What to explain

- Read the text in the context of the conversation and the current project first: a name from the code, a tool in the repo or a term from your last answer means that thing, not a generic one. Look it up in the code if needed.
- If it can mean several things and the context doesn't settle it, give the likeliest meaning and list the others in one line each.
- If the text is empty, explain the last term or concept you used that the user probably didn't know.
- If you don't recognise it (a typo, a made-up word), say so in one line and suggest what they may have meant.

## Output

- Lead with a one-line definition.
- Then only what's needed to understand it: what it's for, a short example, how it relates to what we're doing.
- Add an ASCII diagram if it involves flow, structure or a comparison.
- No preamble, no closing summary.
