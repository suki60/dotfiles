# Preferences

- When a task needs a helper script (parsing JSON/JSONL, data munging, quick automation), write it in Node.js/TypeScript, not Python. The user is a frontend developer whose strongest language is TypeScript and wants to follow what runs.
- Do not run git commands that change the repo or its history (fetch, pull, checkout, switch, merge, rebase, stash, reset, restore, branch deletion, commit, push, etc.). Read-only git for inspecting data (status, diff, log, show, blame, branch listing) is fine, but prefer grep/ls when they are enough.
- Plain shell tools (grep, ls, curl, jq-style one-liners) are still fine when a script would be overkill.
