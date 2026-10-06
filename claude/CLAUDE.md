# Preferences

- When a task needs a helper script (parsing JSON/JSONL, data munging, quick automation), write it in Node.js/TypeScript, not Python. The user is a frontend developer whose strongest language is TypeScript and wants to follow what runs.
- Plain shell tools (grep, ls, curl, jq-style one-liners) are still fine when a script would be overkill.
