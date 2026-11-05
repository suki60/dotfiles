---
name: s
description: Summarize the current conversation as a short recap in a plain-text code block and copy it to the clipboard. Use only when the user invokes /s. Not for summarizing files or documents.
disable-model-invocation: true
---

# Conversation Summary

Produces a copy-paste-friendly recap of the entire conversation so far.

## When to use

Trigger this skill any time the user wants a condensed writeup of the conversation itself (not a summary of an external document or file) that they intend to copy elsewhere — email, notes app, ticket, Slack message, etc. The key signal is "summarize/recap **this conversation/chat**" plus an intent to copy or reuse it outside the chat.

Do NOT use this for:
- Summarizing an uploaded file or document (that's just a normal response, no code block needed).
- Summarizing a past or different conversation — this skill is for the *current* conversation only.

## How to produce the summary

1. **Review the whole conversation from the beginning** — not just the last few messages. Scan for: the topics discussed, questions asked, decisions or conclusions reached, any action items, and important facts, numbers, or names mentioned.
2. **Write a concise summary**, structured roughly like this (adapt headers to fit what actually happened in the chat — skip sections that don't apply):

   ```
   CONVERSATION SUMMARY
   =====================
   Overview: <1-2 sentence framing of what this conversation was about>

   Key points:
   - <point>
   - <point>

   Decisions / conclusions:
   - <item>

   Action items:
   - <item>
   ```

3. **Output format — this is the important part**: put the entire summary inside a single fenced code block (triple backticks, plain text — no language tag needed) in your reply, so it's easy to select and copy. Do NOT create a file or artifact as the deliverable — the point is a quick inline block, not a saved document (the temp file in step 6 only feeds the clipboard).
4. Keep formatting inside the block simple (plain dashes for bullets, no markdown headers like `#`, since code blocks display as literal text). ALL-CAPS or `===` underlines are fine for section titles since they render fine as plain text.
5. Keep the summary tight — favor a few tight bullets over exhaustive detail, unless the user asks for an especially thorough recap.
6. Also copy the summary to the clipboard, so the user only presses ⌘V: write it to a temp file in `/tmp`, then run `pbcopy < <that file>`. A file avoids quoting problems with multi-line text. If `pbcopy` isn't available, skip this step.
7. After the code block, add at most one short sentence, saying "(copied)" if step 6 ran. Don't repeat the summary content outside the block.

## Edge cases

- **Very long/sprawling conversations**: focus on the throughline and most recent/decision-relevant material rather than trying to capture every message; note briefly that older tangents were condensed if that seems useful.
- **User wants it saved as a file instead of pasted**: if they explicitly ask for a file (e.g. "save this as a .md"), that's a different request — write the file where they ask instead of using this skill's code-block output.
