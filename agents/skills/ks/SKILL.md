---
name: ks
description: Stage only the changes related to what the user describes after /ks, leaving every other change unstaged, and write a commit message for everything staged by the /gm skill's rules. Called by the scm-message VS Code extension, which puts the message in the Source Control box. Never commits. Use only when the user invokes /ks.
argument-hint: "<what the changes to stage are about>"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git apply --cached:*)
---

# Stage described changes

Stage only the changes that belong to what the user describes, leave the rest of the working tree as it is, and write the message for what is staged. Invoking `/ks` is the user's go-ahead for this staging. Make no other change to the repo, and never commit.

What to stage, from the user: `$ARGUMENTS`

## Steps

1. If `$ARGUMENTS` is empty, stop without staging anything and say a description is needed.
2. Run `git status --short` and `git diff`. If there are no unstaged changes, stop and say there is nothing to stage. Read untracked files that might be related.
3. Pick the related changes from the description:
   - A whole file is related: `git add -- <path>` (untracked files too).
   - Only some hunks of a file are related: write a patch with just those hunks, copied exactly from `git diff -- <path>`, to the scratchpad directory, then `git apply --cached <patch>`. Never change the working tree.
   - When unsure whether a change is related, leave it out and mention it in the output.
   - If nothing matches the description, stop and say so.
4. Run `git diff --staged` and check the newly staged changes are only the related ones. Changes that were already staged before `/ks` stay as they are.
5. Read `~/.claude/skills/gm/SKILL.md` and write the message by its **Format** rules, from `git diff --staged`, since that is what a commit from the Source Control box will hold.

## Never

- `git add -A`, `git add .`, `git add -p`, or `git commit` of any kind.
- Unstage, restore, stash or edit files to separate changes.
- Any other git command that changes the repo.

## Output

The scm-message extension takes the first fenced code block as the message, so put nothing fenced before it.

- The message alone in a fenced code block.
- Below it, one short line: which type and why.
- The files staged, marking those staged only in part.
- Changes left unstaged that you weren't sure about, one line each.
