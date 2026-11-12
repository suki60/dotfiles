---
name: gws
description: Access the user's Google Workspace (Gmail, Calendar, Drive, Docs, Sheets, Slides, Tasks, Contacts) with the `gws` CLI. Use when a task needs their email, events, files or other Workspace data.
---

# Google Workspace via gws

`gws` is installed and already authenticated as the user.

- Shape: `gws <service> <resource> [sub-resource] <method> --params '<json>' [--json '<body>']`
- Look up a method's parameters before calling it: `gws schema gmail.users.messages.list`
- Output is JSON; use `--format table` for a quick look and `--page-all --page-limit N` for long lists.
- Exit code 2 means auth failed: ask the user to run `gws auth login`, don't try to fix it yourself.

## Safety

- Read freely. Before anything that sends, deletes, shares or edits (send mail, delete an event, change permissions), show the exact command and wait for my go-ahead.
- Never run `gws auth export`: it prints the credentials.
