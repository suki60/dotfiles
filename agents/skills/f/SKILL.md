---
name: f
description: Fill in a web form in Chrome with Claude in Chrome, but never submit it. No argument = work out from the conversation which form and what to fill; any text = which form, what data or how to fill it. Use only when the user invokes /f.
argument-hint: "[which form / what to fill / how]"
disable-model-invocation: true
---

# Fill a form, don't send it

`/f` is the go-ahead to type into a form in my Chrome with the Claude in Chrome tools (`mcp__claude-in-chrome__*`). Load the `claude-in-chrome` skill first and follow it.

## Never submit

The form must stay unsent. I review and send it myself.

- Never click or press anything that submits, sends, saves, publishes, pays, books or confirms ("Submit", "Send", "Save", "Next" on the last step, "Pay", "Confirm"…).
- Never press Enter inside a text input: it can submit the form. Use `form_input` to set values, or type without a trailing Enter.
- Don't call `submit()` or `requestSubmit()` or dispatch submit events with `javascript_tool`.
- Multi-step forms: "Next"/"Continue" is fine only when it clearly just moves to the next page of the same form. If you can't tell whether a button sends or saves, stop and ask.
- If something sends anyway (auto-save, a step that turned out to submit), stop and tell me right away.

## Which form and what to fill

Arguments: `$ARGUMENTS`

- **Empty**: work out from the conversation which form (URL, site, open tab) and what data to use. If it's unclear, check my open tabs with `tabs_context_mcp`; if more than one form fits, ask which.
- **Text**: which form, the data, or how to fill it (tone, language, what to leave blank). It wins over your reading of the conversation; use the conversation for the details it leaves out.

If the form is already open in one of my tabs, fill it there so I can review and send it; otherwise open it in a new tab.

## How to fill

- Read the form first (`read_page` / `find`) to list every field, including required ones and ones further down or in other steps.
- Use only data from the arguments, the conversation, or files/tools I pointed to. Don't invent personal data (names, IDs, addresses, phone numbers, bank details). Leave those blank and list them.
- Free-text fields (descriptions, cover letters, comments): write them from the context, in the form's language unless I say otherwise.
- Don't upload files unless I named them.
- Don't tick consent, terms or marketing boxes unless I said to.
- Skip CAPTCHAs and logins; tell me if one blocks you.
- After filling, check that the values stuck (re-read the fields or take a screenshot) and fix any validation errors shown.

## Output

- The tab it's in, and a bordered table of what you filled (field │ value), short values only.
- The fields left blank and why (missing data, consent, upload, unsure).
- One line reminding me it is not sent.
