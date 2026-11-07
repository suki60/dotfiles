---
name: gl
description: Discard the changes this conversation made that aren't committed yet, or the changes related to what the user describes after /gl, staged or not, keeping a backup in the scratchpad. Use only when the user invokes /gl.
argument-hint: "[what the changes are about]"
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git restore:*), Bash(git apply:*), Bash(git clean -f --:*), Bash(mkdir:*), Bash(cp:*)
---

# Discard this session's changes

Throw away the uncommitted changes in scope, staged or not, so those files match the last commit again. Invoking `/gl` is the user's go-ahead for this one cleanup, an exception to the read-only git rule in CLAUDE.md. Make no other change to the repo.

What the changes are about, from the user (may be empty): `$ARGUMENTS`

## Scope

1. Run read-only git: `git status --short`, `git diff --staged` and `git diff`. Read untracked files that might be in scope.
2. The changes in scope, staged, unstaged or untracked:
   - `$ARGUMENTS` given: the changes related to it.
   - `$ARGUMENTS` empty: the changes this conversation made (files you created or edited, or commands you ran that changed files). A hunk counts only if this conversation wrote it; changes in the same files that were already there stay.
3. Unlike `/gm`, being staged doesn't put a change in scope: staged changes from outside this conversation stay.
4. When unsure whether a change is in scope, leave it and mention it in the output.
5. If nothing is in scope, stop and say so.

## Steps

1. Back up first, in a new folder `gl-<timestamp>` in the scratchpad directory:
   - `git diff --staged -- <paths>` and `git diff -- <paths>` into `staged.patch` and `unstaged.patch`.
   - `cp` each untracked file in scope, keeping its path.
2. Discard:
   - A whole tracked file is in scope: `git restore --staged --worktree -- <path>`.
   - A whole untracked file is in scope: `git clean -f -- <path>`.
   - Only some hunks of a file are in scope: write a patch with just those hunks, copied exactly from `git diff` (or `git diff --staged`), to the backup folder, then `git apply -R <patch>` (add `--cached` for staged hunks; for a hunk staged and in the working tree, run both).
3. Run `git status --short` and `git diff` and check only the changes in scope are gone.

## Never

- `git reset`, `git checkout`, `git stash`, `git clean` without a path, or `git restore .`.
- Discard anything before the backup is written.
- Any other git command that changes the repo, or a commit of any kind.

## Output

- The files discarded, marking those discarded only in part.
- The backup folder's full path, and how to restore it: `git apply <patch>` (`--index` for `staged.patch`), and `cp` for the untracked files.
- Changes left in place that you weren't sure about, one line each.
