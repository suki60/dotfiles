---
name: gs
description: Stage only the changes related to what the user describes after /gs, or the changes this conversation made if no description is given, leaving every other change unstaged. Never commits. Use only when the user invokes /gs.
argument-hint: "[what the changes to stage are about]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git apply --cached:*)
---

# Stage related changes

Stage only the changes that belong to what the user describes, and leave the rest of the working tree as it is. Invoking `/gs` is the user's go-ahead for this staging. Make no other change to the repo, and never commit.

What to stage, from the user (may be empty): `$ARGUMENTS`

## Steps

1. If `$ARGUMENTS` is empty, the related changes are the ones this conversation made (files you created or edited, or commands you ran that changed files). If this conversation made no changes, stop and ask what the changes are about.
2. Run `git status --short` and `git diff`. If there are no unstaged changes, stop and say there is nothing to stage. Read untracked files that might be related.
3. Pick the related changes, using the description and, if this conversation made the changes, what you know about them. With no description, a hunk is related only if this conversation wrote it; leave out changes in the same files that were already there:
   - A whole file is related: `git add -- <path>` (untracked files too).
   - Only some hunks of a file are related: write a patch with just those hunks, copied exactly from `git diff -- <path>`, to the scratchpad directory, then `git apply --cached <patch>`. Never change the working tree.
   - When unsure whether a change is related, leave it out and mention it in the output.
   - If nothing matches the description (or nothing this conversation made is still unstaged), stop and say so.
4. Run `git diff --staged --stat` and check the newly staged changes are only the related ones. Changes that were already staged before `/gs` stay as they are.

## Never

- `git add -A`, `git add .`, `git add -p`, or `git commit` of any kind.
- Unstage, restore, stash or edit files to separate changes.
- Any other git command that changes the repo.

## Output

- The files staged, marking those staged only in part.
- Changes left unstaged that you weren't sure about, one line each.
