---
name: km
description: Write a Conventional Commits message for the staged changes, or for all changes if nothing is staged, by the /gm skill's rules. Called by the scm-message VS Code extension, which puts the message in the Source Control box. Use only when the user invokes /km. Never stages or commits.
argument-hint: "[hint about the change]"
disable-model-invocation: true
---

# Commit message for staged or all changes

Write one commit message for the current changes. Never run `git add`, `git commit` or any git command that changes the repo.

Hint from the user (may be empty): `$ARGUMENTS`

## Steps

1. Run read-only git: `git status --short`, then `git diff --staged`.
2. If nothing is staged, use `git diff` plus the untracked files from `git status` instead. If there are no changes at all, stop and say there is nothing to describe.
3. Read `~/.claude/skills/gm/SKILL.md` and write the message by its **Format** rules.

## Output

The scm-message extension takes the first fenced code block as the message, so put nothing fenced before it.

- The message alone in a fenced code block.
- Below it, one short line: which type and why.
- If nothing was staged, one line saying the message is for all changes.
- If the changes are clearly two unrelated things, add one line suggesting a split, with a message for each.
