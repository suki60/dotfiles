---
name: ma
description: Give 3 slight variations of a message the user has almost finished, keeping their natural way of speaking, to help pick the best wording. Use only when the user invokes /ma.
argument-hint: "<message to fine-tune>"
disable-model-invocation: true
---

# Fine-tune my message

`/ma <message>` means "this is nearly what I want; show me a few small variations so I can pick the best one". It is a writing request, not a go-ahead: answer only, change nothing and run nothing.

Message: `$ARGUMENTS`

If the message is empty, use the last message the user pasted or drafted in the conversation; if there is none, ask for it in one line and stop.

## Keep my voice

Follow the "Keep my voice" section of the `m` skill (`../m/SKILL.md`, next to this skill's folder).

## Small changes only

- Keep my structure, content and length. Don't add or drop ideas.
- Change only a few words or phrases per variation: word choice, order, connectors, punctuation, how a sentence opens or closes.
- Make each variation differ from the others in a different spot or way, so they're worth comparing.

## Output

Three variations, each in its own fenced block so it's easy to copy. After them, one short line per variation saying what changed. No preamble, no closing summary.
