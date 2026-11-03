---
name: m
description: Suggest a commit message in Conventional Commits style for the current changes. Use when the user invokes /m or asks for a commit message suggestion. Suggests only; never commits.
argument-hint: "[hint about the change]"
---

# Commit message suggestion

Suggest one commit message for the current changes. Never run `git add`, `git commit` or any git command that changes the repo: the user commits themselves.

Hint from the user (may be empty): `$ARGUMENTS`

## What to look at

1. Run read-only git: `git status --short`, then `git diff --staged`.
2. If nothing is staged, use `git diff` plus the untracked files from `git status` instead, and say the message is for the unstaged changes.
3. If this conversation made the changes, use what you know about why they were made, not only the diff.

## Format

`<type>: <description>`

- type, picked with this order of questions:
  - Does the app behave differently for the user? Broken before → `fix:`, otherwise → `feat:`.
  - Only the code's shape changed, same behaviour → `refactor:`.
  - Only README, PLAN.md, comments or other docs → `docs:`.
  - Deps, config, scripts, deleting unused files → `chore:`.
- A commit that mixes types takes the main one (the change the others exist for).
- description: imperative ("add X", not "added X"), lowercase start, no trailing period, the whole line under ~72 characters.
- No scope in parentheses, no body, unless the user asks.
- Ignore older commits in `git log` that use `add:` / `upd:` / `rm:`: that convention was dropped.

## Output

- Copy the message to the clipboard, so the user only presses ⌘V in VS Code's Source Control box: `printf '%s' '<message>' | pbcopy` (single quotes; escape any `'` in the message as `'\''`). With a split suggestion, copy the first message.
- The message alone in a fenced code block.
- Below it, one short line: which type and why (e.g. "feat: the answer step now runs in the browser"), ending with "(copied)".
- If the changes are clearly two unrelated things, add one line suggesting a split, with a message for each.
