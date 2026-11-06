---
name: gs
description: Stage the changes this conversation made that aren't committed yet, or the changes related to what the user describes after /gs, and write a commit message for them the way /gm does. Never commits. Use only when the user invokes /gs.
argument-hint: "[what the changes are about]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git apply --cached:*), Bash(printf:*), Bash(pbcopy:*)
---

# Stage this session's changes

Stage the changes in scope and write their commit message. Invoking `/gs` is the user's go-ahead for this staging. Make no other change to the repo, and never commit.

What the changes are about, from the user (may be empty): `$ARGUMENTS`

## Steps

1. Read `~/.claude/skills/gm/SKILL.md` and pick the changes by its **Scope** rules, with the description above.
2. Stage the unstaged changes in scope; what is already staged stays as it is:
   - A whole file is in scope: `git add -- <path>` (untracked files too).
   - Only some hunks of a file are in scope: write a patch with just those hunks, copied exactly from `git diff -- <path>`, to the scratchpad directory, then `git apply --cached <patch>`. Never change the working tree.
3. Run `git diff --staged` and check it holds only the changes in scope.
4. Write the message by `/gm`'s **Format** rules, from `git diff --staged`.
5. Copy the message to the clipboard: `printf '%s' '<message>' | pbcopy`.

## Never

- `git add -A`, `git add .`, `git add -p`, or `git commit` of any kind.
- Unstage, restore, stash or edit files to separate changes.
- Any other git command that changes the repo.

## Output

- Everything `/gm` outputs, with "in scope" meaning staged.
