# Preferences

- When a task needs a helper script (parsing JSON/JSONL, data munging, quick automation), write it in Node.js/TypeScript, not Python. The user is a frontend developer whose strongest language is TypeScript and wants to follow what runs.
- Do not run git commands that change the repo or its history (fetch, pull, checkout, switch, merge, rebase, stash, reset, restore, branch deletion, commit, push, etc.). Read-only git for inspecting data (status, diff, log, show, blame, branch listing) is fine, but prefer grep/ls when they are enough.
- Plain shell tools (grep, ls, curl, jq-style one-liners) are still fine when a script would be overkill.
- Only create, edit or delete files, or run commands that change anything, when I explicitly ask for it. When I am asking questions or discussing ("is there a way to...?", "how would...?"), answer and explain only; offer to do it and wait for my go-ahead.
- When you do act, tell me every file you created or changed, including temporary scripts outside the repo.
