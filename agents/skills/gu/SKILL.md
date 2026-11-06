---
name: gu
description: Stage and commit the changes this conversation made that aren't committed yet, or the changes related to what the user describes after /gu, the way /gc does, then push the current branch. Use only when the user invokes /gu.
argument-hint: "[what the changes are about]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git apply --cached:*), Bash(git commit:*), Bash(git log:*), Bash(git push)
---

# Commit and push this session's changes

Commit exactly as `/gc` does, then push. Invoking `/gu` is the user's go-ahead for this one commit and one push, an exception to the read-only git rule in CLAUDE.md. Make no other change to the repo.

What the changes are about, from the user (may be empty): `$ARGUMENTS`

## Steps

1. Read `~/.claude/skills/gc/SKILL.md` and follow its **Steps** and **Never** rules, with the description above. Its ban on `push` is lifted only for step 2.
2. If the commit succeeded, run `git push`. If it failed or there was nothing to commit, stop without pushing.

## Never

- `git push` with any arguments or flags (`--force`, `--set-upstream`, a remote or branch name).
- Retry or work around a failing push (no upstream, rejected, auth error). Show its output and stop; the commit stays.

## Output

- Everything `/gc` outputs.
- One line: pushed, or why the push failed.
