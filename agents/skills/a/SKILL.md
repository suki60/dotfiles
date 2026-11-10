---
name: a
description: Give alternatives to a solution. No argument = alternatives to the latest solution in this conversation; any text = alternatives to that, or to the latest solution with that focus. Use only when the user invokes /a.
argument-hint: "[solution or what matters to me]"
disable-model-invocation: true
---

# Alternatives?

`/a` means "what other ways are there to do this?". It is a question, not a go-ahead: answer only, change nothing.

Context from the user (may be empty): `$ARGUMENTS`

## What to find alternatives for

- **Empty**: the latest solution in this conversation (your last proposal, recommendation or change). Start with `Solution: <solution>` in one line so I can correct it.
- **Text about the conversation** (a constraint, a focus, "without a library", "simpler", "faster"): alternatives to the latest solution, judged by what the text says matters.
- **Text naming a different solution or problem**: alternatives to that. Read code or files first if the answer depends on them.
- If the conversation has nothing to go on and no text is given, ask in one line what solution I want alternatives for and stop.

## Steps

1. Look at this project first (stack, versions, existing patterns) so the alternatives fit it.
2. List 2-4 real alternatives that differ in approach, not just in detail. Include the current solution as the baseline. For each: one line on how it works, and a tiny example in this project's language when it helps.
3. A bordered comparison table of the points that matter (effort, complexity, performance, maintenance, fit with this code, and anything named in the context above).
4. One line: `Pick: <option>`, with when each of the others would win instead. If the current solution is still the best, say so.
5. If an alternative depends on something recent (library versions, new APIs), check the official docs rather than answering from memory, and link the source.
6. Offer to apply the pick and wait for my go-ahead (`y`, `/d`, `/n` or a reply).

## How to draw

Follow the "How to draw" section of the `v` skill (`../v/SKILL.md`, next to this skill's folder). Add a diagram only when the alternatives differ in flow or structure.
