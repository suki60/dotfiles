---
name: v
description: Explain something visually with ASCII diagrams in the terminal. No argument = re-explain the last answer visually; a file path = explain that file visually; any other text = explain that topic or question visually.
argument-hint: "[file path | question]"
---

# Visual explanation

The user learns best from pictures. Explain with ASCII diagrams in a fenced code block, not with paragraphs.

## What to explain

Arguments: `$ARGUMENTS`

- **Empty**: take your previous answer in this conversation and explain the same content visually. Don't add new facts; redraw what was said.
- **A file path** (an existing file, e.g. `src/eval.ts` or `@src/eval.ts`): read the file and explain it visually, top to bottom.
- **Anything else**: treat it as a question or topic and answer it visually. Read code or files first if the answer depends on them.

## How to draw

- Boxes (`┌─┐ │ └─┘`) for parts/stages, arrows (`──►`, `▼`) for flow of data or time, `◄──` for short side notes.
- For a file: one box per section in source order, with its line range in the box title (`── lines 31-78 ─┐`). Show what goes in and what comes out of each part, with a tiny concrete example value (`[0.12, …]`, `rank = 2`).
- For a process: the steps in order, who does each one (me / you) when that matters.
- For a comparison: a side-by-side table or two aligned rows.
- Use real names from the code (functions, variables, files) so the user can find them.
- Mark made-up example values as examples; never present them as measured.
- Keep lines under ~75 characters so they don't wrap in the terminal.

## Around the diagram

- One line before the diagram saying what it shows.
- After it, at most 2-3 short bullets for the key idea the picture can't carry (e.g. "the same function runs both searches; only the setting changes").
- No preamble, no closing summary, no offers of further help.
