---
name: rev
description: Review your own last response or the change you just made, and say whether it's good enough or what's missing or could be better. No argument = the last response; any text = what to review or focus on. Use only when the user invokes /rev.
argument-hint: "[what to review / focus]"
disable-model-invocation: true
---

# Review your last response

`/rev` means "does it look good?". It is a question, not a go-ahead: answer only, change nothing and run nothing. Offer the fixes and wait for my `y`.

Focus from the user (may be empty): `$ARGUMENTS`

## What to review

- **Empty**: your last response, and any files you created or changed in it.
- **Text**: use it to pick what to review (e.g. "the /p skill", "the commit message") or what to focus on (e.g. "edge cases", "naming").
- Re-read the files you changed instead of trusting memory, and compare with similar existing code or files for consistency.

## What to look for

- **Correctness**: wrong facts, bugs, steps that won't work as written.
- **Gaps**: edge cases not handled, things I asked for that were missed or only half done.
- **Fit**: matches my instructions (CLAUDE.md, AGENTS.md) and the conventions around it.
- **Simpler**: anything that could be shorter or clearer.

Be honest: if it's good, say so and stop. Don't invent issues to have something to say.

## Output

- One line verdict: good as is, or mostly good with N tweaks.
- The findings in a bordered table (gap │ suggested fix), most important first.
- One line on which ones you recommend, so `y` alone applies those.
- No preamble, no closing summary.
