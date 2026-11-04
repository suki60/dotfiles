---
name: gc
description: Commit the staged changes with a Conventional Commits message written by the /gm skill's rules. Use only when the user invokes /gc.
argument-hint: "[hint about the change]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git commit:*), Bash(git log:*)
---

# Commit staged changes

Commit what is staged, with a message written the way `/gm` writes one. Invoking `/gc` is the user's go-ahead for this one commit, an exception to the read-only git rule in CLAUDE.md. Make no other change to the repo.

Hint from the user (may be empty): `$ARGUMENTS`

## Steps

1. Run `git diff --staged --stat`. If nothing is staged, stop and say so. Never run `git add`: only what the user staged gets committed.
2. Read `~/.claude/skills/gm/SKILL.md` and write the message by its **Format** rules, from `git diff --staged` only (ignore unstaged and untracked files). If this conversation made the changes, use what you know about why.
3. Commit: `git commit -m '<message>'` (single quotes; escape any `'` in the message as `'\''`). No body and no trailer lines, matching `/gm`.
4. If the staged changes are clearly two unrelated things, still commit them as one, then add a line saying a split would have been cleaner.

## Never

- `git add`, `--amend`, `--no-verify`, `push`, or any other git command that changes the repo.
- Retry or work around a failing pre-commit hook. Show its output and stop.

## Output

- The commit's short hash and message, from `git log -1 --oneline`, in a fenced code block.
- One short line: which type and why (as in `/gm`).
