---
name: b
description: Answer what the best, most common or recommended way is to achieve what the user describes after /b (or, with nothing after it, what this conversation is working on), following current best practices. Use only when the user invokes /b.
argument-hint: "[what I want to achieve]"
disable-model-invocation: true
---

# Best way?

`/b` means "what is the best or most common way to do this, and what are the best practices?". It is a question, not a go-ahead: answer only, change nothing.

What I want to achieve, from the user (may be empty): `$ARGUMENTS`

If that is empty, the goal is what this conversation is currently working on: the latest task, question or change in progress. Start the answer with `Goal: <goal>` in one line so I can correct it. Only if the conversation has nothing to go on, ask in one line what I want to achieve and stop.

## Steps

1. Look at this project first (stack, versions, existing patterns) so the answer fits it. If the goal is unclear, ask one short question and stop.
2. One line: `Best way: <approach>`. Say if it is also the most common one; if the common way differs from the best one, name both.
3. A short example in this project's language and style, using real names from the code where it applies.
4. Best practices: at most 5 short bullets (do's, don'ts, common pitfalls).
5. Alternatives: one line each, with when to pick them instead.
6. If the answer depends on something recent (library versions, new APIs), check the official docs rather than answering from memory, and link the source.
7. Offer to apply it and wait for my go-ahead (`y`, `/d`, `/n` or a reply).

## How to draw

When a flow, structure or comparison helps, follow the "How to draw" section of the `v` skill (`../v/SKILL.md`, next to this skill's folder).
