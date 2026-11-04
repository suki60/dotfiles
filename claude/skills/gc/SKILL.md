---
name: gc
description: Commit the staged changes, or all changes if nothing is staged, with a Conventional Commits message written by the /gm skill's rules. Use only when the user invokes /gc.
argument-hint: "[hint about the change]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(git log:*)
---

# Commit changes

Commit what is staged, or every change if nothing is staged, with a message written the way `/gm` writes one. Invoking `/gc` is the user's go-ahead for this one commit, an exception to the read-only git rule in CLAUDE.md. Make no other change to the repo.

Hint from the user (may be empty): `$ARGUMENTS`

## Steps

1. Run `git diff --staged --stat`.
   - Something is staged: commit only that. Don't run `git add`; ignore unstaged and untracked files.
   - Nothing is staged: run `git status --short`. If it's empty, stop and say there is nothing to commit. Otherwise run `git add -A` to stage every change, untracked files included.
2. Read `~/.claude/skills/gm/SKILL.md` and write the message by its **Format** rules, from `git diff --staged` only. If this conversation made the changes, use what you know about why.
3. Commit: `git commit -m '<message>'` (single quotes; escape any `'` in the message as `'\''`). No body and no trailer lines, matching `/gm`.
4. If the committed changes are clearly two unrelated things, still commit them as one, then add a line saying a split would have been cleaner.

## Never

- `git add` when something was already staged, or any `git add` other than `git add -A` in step 1.
- `--amend`, `--no-verify`, `push`, or any other git command that changes the repo.
- Retry or work around a failing pre-commit hook. Show its output and stop.

## Output

- The commit's short hash and message, from `git log -1 --oneline`, in a fenced code block.
- One short line: which type and why (as in `/gm`).
- If step 1 staged everything, one line saying so.
