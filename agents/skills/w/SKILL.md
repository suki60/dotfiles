---
name: w
description: Explain visually why your recommended option wins over the others from your latest answer. Use only when the user invokes /w.
argument-hint: "[what matters most to me]"
disable-model-invocation: true
---

# Why that pick?

`/w` means "explain the reasoning behind your recommendation, with pictures". It is a question, not a go-ahead: answer only, change nothing.

Context from the user (may be empty): `$ARGUMENTS`

## Steps

1. Find the recommendation in your latest answer. If it had options but no pick, pick one first. Re-check honestly; if another option now looks better, say so and explain that one.
2. One line: `Pick: <option>`.
3. A diagram comparing the pick with the other options on the points that matter (to this project and to the context above).
4. If it helps, a second diagram of how the pick works in this code: real files, functions and data flow.
5. At most 3 short bullets for what the diagrams can't carry, and one line on when another option would win.
6. Wait for my go-ahead (`/n` or a reply).

## How to draw

Follow the "How to draw" section of the `v` skill (`../v/SKILL.md`, next to this skill's folder).
