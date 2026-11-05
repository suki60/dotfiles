---
name: slim
description: Clean up and simplify code so it stays minimal and easy to read file by file. Removes outdated or historical comments, defensive code for cases that don't happen, finished experiments, dead code and type-only noise, without changing behaviour or performance. Use when the user invokes /slim or asks to clean up, simplify, refactor for readability or keep the code minimal.
argument-hint: "[file, folder or empty for the whole repo]"
---

# Slim the code

Make the code as small and readable as it can be while doing exactly what it does now. Less code and shorter comments are the goal.

Scope (may be empty): `$ARGUMENTS`

- **Empty**: every tracked source file (`git ls-files`), skipping lockfiles, generated files, data and docs.
- **A file or folder**: only that.

Invoking `/slim` is the go-ahead to edit the files in scope.

## Steps

1. Read every file in scope fully before changing anything. Also read what imports or calls it, so nothing in use gets removed.
2. Work out what the code needs **now**: the entry points, scripts, tests and tools the project still uses (package scripts, README, CI config). Everything else is a candidate for removal.
3. Apply the cuts below, file by file.
4. Run the project's formatter, typecheck and linter if it has them, and fix what they report. Then re-check any formatting rules from CLAUDE.md on lines the formatter rewrote.
5. Running the app, slow tests or anything that changes data follows the user's instructions. When none are given, run what's safe and list the rest as commands with the expected result.

## Cut

- **History in comments**: version or phase notes, "was X before", "changed in …", commit references, old measurements. History belongs in git and the PR. A comment says what the code does and why, in present tense, and only when the code doesn't already say it.
- **Long comments**: shorten to one or two lines. Remove comments that repeat the code.
- **Defensive code for cases that don't happen**: extra checks, "just in case" sorting or retries, validation of data the project produces itself, fallbacks for failures nobody has observed. Keep guards against real, observed failures and against untrusted input.
- **Type-only noise**: fallbacks, guards and casts added only to satisfy a strict compiler option. If one option causes most of it, turning it off is allowed: say so in the report.
- **Finished experiments**: comparison modes, flags and branches whose decision is made.
- **Dead code**: unused functions, exports, variables, files, config and dependencies. List package removals as commands rather than editing lockfiles by hand.
- **Indirection**: helpers used once, wrappers that only pass through, options objects with one option, layers with a single implementation. Inline them. Extract a helper only when it removes real repetition.

## Keep

- **Behaviour**: the same inputs give the same results. Changing log or console output is fine, but report it.
- **Performance**: never swap a deliberate optimisation for a simpler but slower version. If unsure, keep the code and shorten its comment.
- **Fixes for real failures**: keep the code and a one-line reason for it.
- **Security and correctness checks** on untrusted input (user input, network, files from elsewhere).
- **The project's style**: naming, idioms, and the formatting rules in CLAUDE.md.

When a cut would remove a feature the user might still want (a UI element, a metric, an option, a mode), don't decide alone: list it and ask before removing it.

## Report

- A bordered table of the kinds of cuts, each with an example and the files it touched.
- A table of what the user will notice (output, UI, removed checks, changed compiler options).
- Every file changed, the line totals from `git diff --stat`, and whether formatter, typecheck, lint and tests pass.
- Anything you got wrong and corrected along the way.
- The commands the user should run to verify, with the expected results, then a suggested Conventional Commit message (`refactor: …`).
