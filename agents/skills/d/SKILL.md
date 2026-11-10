---
name: d
description: Do the option you recommended in your latest answer (the pick from /w, /a, /b or any answer with options). Use only when the user invokes /d.
argument-hint: "[notes to adjust the pick]"
disable-model-invocation: true
---

# Do it

`/d` means "do the option you just recommended". It is my go-ahead to apply it.

Notes from the user (may be empty): `$ARGUMENTS`

## Steps

1. Find the pick in your latest answer: the `Pick:` line, or the option marked as recommended.
   - Several options and no pick: ask which one in one line and stop.
   - No offer to act on at all: say so in one line and stop.
2. Say in one line what you're applying.
3. Apply it the usual way, adjusted by the notes above if given. Change only what the pick needs.
4. Finish as any finished step does: every file changed, the checks you ran, and a suggested commit message.
