---
name: gm
description: Write a Conventional Commits message for the changes this conversation made that aren't committed yet, or for the changes related to what the user describes after /gm. Use only when the user invokes /gm. Suggests only; never stages or commits.
argument-hint: "[what the changes are about]"
disable-model-invocation: true
---

# Commit message for this session's changes

Write one commit message for the changes in scope. Never run `git add`, `git commit` or any git command that changes the repo.

What the changes are about, from the user (may be empty): `$ARGUMENTS`

## Scope

The skills `/gs`, `/gc` and `/gu` use this same scope, so the message always describes what they would commit.

1. Run read-only git: `git status --short`, `git diff --staged` and `git diff`. Read untracked files that might be in scope.
2. The changes in scope are everything already staged, plus:
   - `$ARGUMENTS` given: the unstaged and untracked changes related to it.
   - `$ARGUMENTS` empty: the unstaged and untracked changes this conversation made (files you created or edited, or commands you ran that changed files). A hunk counts only if this conversation wrote it; changes in the same files that were already there stay out.
3. Committed changes are never in scope: anything an earlier `/gc`, `/gu` or other commit in this conversation already recorded no longer shows in `git diff`. A message written earlier (by `/gm` or `/gs`) doesn't count as handled; its changes stay in scope until committed.
4. When unsure whether a change is in scope, leave it out and mention it in the output.
5. If nothing is in scope, stop and say so: nothing staged, and nothing related to the description (or nothing this conversation made is still uncommitted).

## Format

`<type>: <description>`

- type, picked with this order of questions:
  - Does the app behave differently for the user? Broken before → `fix:`, otherwise → `feat:`.
  - Only the code's shape changed, same behaviour → `refactor:`.
  - Only README, PLAN.md, comments or other docs → `docs:`.
  - Deps, config, scripts, deleting unused files → `chore:`.
- A commit that mixes types takes the main one (the change the others exist for).
- description: imperative ("add X", not "added X"), lowercase start, no trailing period, the whole line under ~72 characters.
- No scope in parentheses, no body, unless the user asks.
- If this conversation made the changes, use what you know about why they were made, not only the diff.
- Ignore older commits in `git log` that use `add:` / `upd:` / `rm:`: that convention was dropped.

## Output

- The message alone in a fenced code block.
- Below it, one short line: which type and why (e.g. "feat: the answer step now runs in the browser").
- The files in scope, marking those in scope only in part.
- Changes left out that you weren't sure about, one line each.
- If the changes are clearly two unrelated things, add one line suggesting a split, with a message for each.
