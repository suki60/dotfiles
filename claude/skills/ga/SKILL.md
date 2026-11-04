---
name: ga
description: Commit only the changes related to what the user describes after /ga, leaving every other change uncommitted, with a Conventional Commits message written by the /gm skill's rules. Use only when the user invokes /ga.
argument-hint: "<what the changes to commit are about>"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git apply --cached:*), Bash(git commit:*), Bash(git log:*)
---

# Commit related changes

Commit only the changes that belong to what the user describes, and leave the rest of the working tree as it is. Invoking `/ga` is the user's go-ahead for this one commit, an exception to the read-only git rule in CLAUDE.md. Make no other change to the repo.

What to commit, from the user: `$ARGUMENTS`

## Steps

1. If `$ARGUMENTS` is empty, stop and ask what the changes are about.
2. Run `git diff --staged --stat`. If anything is staged, stop: say which files are staged and ask the user to unstage them or use `/gc`. Don't unstage them yourself.
3. Run `git status --short` and `git diff`. If there are no changes, stop and say there is nothing to commit. Read untracked files that might be related.
4. Pick the related changes, using the description and, if this conversation made the changes, what you know about them:
   - A whole file is related: `git add -- <path>` (untracked files too).
   - Only some hunks of a file are related: write a patch with just those hunks, copied exactly from `git diff -- <path>`, to the scratchpad directory, then `git apply --cached <patch>`. Never change the working tree.
   - When unsure whether a change is related, leave it out and mention it in the output.
   - If nothing matches the description, stop and say so.
5. Run `git diff --staged` and check it holds only the related changes.
6. Read `~/.claude/skills/gm/SKILL.md` and write the message by its **Format** rules, from `git diff --staged` and the user's description.
7. Commit: `git commit -m '<message>'` (single quotes; escape any `'` in the message as `'\''`). No body and no trailer lines, matching `/gm`.

## Never

- `git add -A`, `git add .`, `git add -p`, or `git commit -a`.
- Unstage, restore, stash or edit files to separate changes.
- `--amend`, `--no-verify`, `push`, or any other git command that changes the repo.
- Retry or work around a failing pre-commit hook. Show its output and stop.

## Output

- The commit's short hash and message, from `git log -1 --oneline`, in a fenced code block.
- One short line: which type and why (as in `/gm`).
- The files committed, marking those committed only in part.
- Changes left uncommitted that you weren't sure about, one line each.
