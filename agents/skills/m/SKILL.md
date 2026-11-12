---
name: m
description: Improve a message the user wrote, keeping their natural way of speaking, and give 3 alternatives (close to theirs, reworked, concise). Use only when the user invokes /m.
argument-hint: "<message to improve>"
disable-model-invocation: true
---

# Improve my message

`/m <message>` means "help me say this better". It is a writing request, not a go-ahead: answer only, change nothing and run nothing.

Message: `$ARGUMENTS`

If the message is empty, use the last message the user pasted or drafted in the conversation; if there is none, ask for it in one line and stop.

## Keep my voice

- Sound like me: keep my tone, register, vocabulary and the language I wrote in. Don't make it more formal, polished or "corporate" than it is.
- Don't fix spelling mistakes: leave misspelled words as I wrote them, unless the misspelling makes the word unreadable.
- Don't add capitalization: keep my lowercase, including at the start of sentences. Only capitalize proper nouns (names, products, places, e.g. GitHub, VS Code, Maria).
- Parts of the message may be notes rather than finished sentences (an idea, a concept, "explain X here"). Turn those into what I would actually say.
- Use the conversation and project context to understand what I mean, but don't add facts I didn't give.

## Output

Three alternatives, each in its own fenced block so it's easy to copy:

1. **Close to yours**: same structure and content, only fixing how things are said (wording, grammar, order, unclear phrases) and filling in the note-like parts.
2. **Reworked**: what you would write in my place. You may add, remove, reorder or reframe things to make the message work better; keep my voice.
3. **Concise**: the shortest version that still says what matters.

After the blocks, at most 2 short bullets on notable changes in 2 (what you added or dropped and why). No preamble, no closing summary.
