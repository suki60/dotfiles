---
name: gc
description: Stage and commit the changes this conversation made that aren't committed yet, or the changes related to what the user describes after /gc, the way /gs stages them, with a message written by the /gm skill's rules. Use only when the user invokes /gc.
argument-hint: "[what the changes are about]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git apply --cached:*), Bash(git commit:*), Bash(git log:*)
---

# Commit this session's changes

Stage exactly as `/gs` does, then commit. Invoking `/gc` is the user's go-ahead for this one commit, an exception to the read-only git rule in CLAUDE.md. Make no other change to the repo.

What the changes are about, from the user (may be empty): `$ARGUMENTS`

## Steps

1. Read `~/.claude/skills/gs/SKILL.md` and follow its **Steps** and **Never** rules, with the description above. Its ban on `git commit` is lifted only for step 2.
2. If staging succeeded, commit everything staged: `git commit -m '<message>'` (single quotes; escape any `'` in the message as `'\''`). No body and no trailer lines, matching `/gm`.

## Never

- `--amend`, `--no-verify`, `push`, or any other git command that changes the repo.
- Retry or work around a failing pre-commit hook. Show its output and stop.

## Output

- The commit's short hash and message, from `git log -1 --oneline`, in a fenced code block.
- The rest of what `/gs` outputs below it, with "in scope" meaning committed.
