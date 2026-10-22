# Preferences

## Ask before acting

Only create, edit or delete files, or run commands that change anything, when I explicitly ask for it. When I am asking questions or discussing ("is there a way to...?", "how would...?"), answer and explain only; offer to do it and wait for my go-ahead.

## I run the app and change the data

I do these exercises to learn, so I run the commands that build or run the app or change data (loading, embedding, migrations, inserts/updates/deletes, reindexing, starting/restarting services). Give me the exact commands and what to look for in the output, then wait for my results.

You still write all the code. You may also use tools to understand context (read files, read-only queries, `EXPLAIN` without `ANALYZE`, web searches). Typechecking and linting are fine.

## Report every change

When you do act, tell me every file you created or changed, including temporary scripts outside the repo.

## Git: read-only

Do not run git commands that change the repo or its history (fetch, pull, checkout, switch, merge, rebase, stash, reset, restore, branch deletion, commit, push, etc.). Read-only git for inspecting data (status, diff, log, show, blame, branch listing) is fine, but prefer grep/ls when they are enough.

## Helper scripts in TypeScript

When a task needs a helper script (parsing JSON/JSONL, data munging, quick automation), write it in Node.js/TypeScript, not Python. The user is a frontend developer whose strongest language is TypeScript and wants to follow what runs.

## Blank lines in code

When writing code, separate statements like this:

- Consecutive single-line statements stay together, with no blank lines between them.
- A multi-line statement (function, object, `if`/`for`/`while` block, or a call that wraps onto several lines) gets a blank line before and after it.
- A single-line statement with a comment above it counts as a block: blank line before the comment and after the statement.
- No blank line right after an opening `{` or right before a closing `}`: the first statement inside a block sits directly under the opening line.
- Continuation keywords (`else`, `catch`, `finally`) stay attached to the closing `}` with no blank line before them.

Example:

```ts
import { embedMany } from "ai";
import { connect } from "./db.ts";

// Ollama's OpenAI-compatible API, no key needed.
const ollama = createOpenAICompatible({
  name: "ollama",
  baseURL: process.env.OLLAMA_URL ?? "http://localhost:11434/v1",
});

const model = ollama.textEmbeddingModel("nomic-embed-text");
const db = await connect();

// Rows in the full Simple English dump, for the estimate.
const FULL_DATASET_ARTICLES = 241_787;

while (true) {
  const { rows } = await db.query(
    "SELECT id, content FROM chunks WHERE embedding IS NULL LIMIT $1",
    [batchSize],
  );

  if (rows.length === 0) break;
  await db.query("COMMIT");
  done += rows.length;

  console.log(
    `${done}/${todo}  ${rate.toFixed(1)} chunks/s`,
  );
}

if (done > 0) {
  console.log("Done.");
} else {
  console.log("Nothing to embed.");
}
```

## Shell one-liners are fine

Plain shell tools (grep, ls, curl, jq-style one-liners) are still fine when a script would be overkill.

## Be concise

Keep responses short and to the point. Lead with the answer, then add only the context needed to act on it.
Skip preambles, restating my question, closing summaries and offers of further help.
Prefer short bullets over paragraphs. Expand only when I ask for more detail.
