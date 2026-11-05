# Blank lines in code

When writing code, separate statements like this:

- Consecutive single-line statements stay together, with no blank lines between them.
- A multi-line statement (function, object, `if`/`for`/`while` block, or a call that wraps onto several lines) gets a blank line before and after it.
- A single-line statement with a comment above it counts as a block: blank line before the comment and after the statement.
- No blank line right after an opening `{` or right before a closing `}`: the first statement inside a block sits directly under the opening line.
- Continuation keywords (`else`, `catch`, `finally`) stay attached to the closing `}` with no blank line before them.
- JSX has no blank lines inside it: elements and `{…}` expressions sit directly one under another, even multi-line ones. The rules above apply to the statements around the JSX, not to the markup.

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

let done = 0;

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
