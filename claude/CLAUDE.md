# Preferences

## Ask before acting

Only create, edit or delete files, or run commands that change anything, when I explicitly ask for it. When I am asking questions or discussing ("is there a way to...?", "how would...?"), answer and explain only; offer to do it and wait for my go-ahead.

## Report every change

When you do act, tell me every file you created or changed, including temporary scripts outside the repo.

## Git: read-only

Do not run git commands that change the repo or its history (fetch, pull, checkout, switch, merge, rebase, stash, reset, restore, branch deletion, commit, push, etc.). Read-only git for inspecting data (status, diff, log, show, blame, branch listing) is fine, but prefer grep/ls when they are enough.

## Helper scripts in TypeScript

When a task needs a helper script (parsing JSON/JSONL, data munging, quick automation), write it in Node.js/TypeScript, not Python. The user is a frontend developer whose strongest language is TypeScript and wants to follow what runs.

## Shell one-liners are fine

Plain shell tools (grep, ls, curl, jq-style one-liners) are still fine when a script would be overkill.

## Be concise

Keep responses short and to the point. Lead with the answer, then add only the context needed to act on it.
Skip preambles, restating my question, closing summaries and offers of further help.
Prefer short bullets over paragraphs. Expand only when I ask for more detail.
