#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Paste
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⇤
# @raycast.packageName Text

# Documentation:
# @raycast.description Remove the shared leading indent from the clipboard text and paste it
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

set -euo pipefail

# Locate `node` even when Raycast runs with a minimal PATH (node comes from nvm)
node_bin="$(command -v node || true)"
if [ -z "$node_bin" ]; then
  node_bin="$(ls -d "$HOME"/.nvm/versions/node/*/bin/node 2>/dev/null | sort -V | tail -n 1 || true)"
fi

if [ -z "$node_bin" ] || [ ! -x "$node_bin" ]; then
  echo "Could not find the 'node' command"
  exit 1
fi

"$node_bin" - <<'EOF'
const { execSync } = require("node:child_process");

const text = execSync("pbpaste", { encoding: "utf8" });
const lines = text.split("\n");
const indentOf = (line) => line.match(/^[ \t]*/)[0].length;

const rest = lines.slice(1).filter((line) => line.trim() !== "");
const restIndents = rest.map(indentOf);

// Indent unit = smallest step between indent levels (fallback: 2)
const levels = [...new Set(restIndents)].sort((a, b) => a - b);
const steps = levels.slice(1).map((n, i) => n - levels[i]);
const unit = steps.length ? Math.min(...steps) : 2;

// A selection that starts mid-line gives line 1 no indent, so guess where it
// really started: one level above line 2 if it opens a block, else level with it
let firstIndent = indentOf(lines[0]);
if (firstIndent === 0 && rest.length) {
  const opensBlock = /[{([]\s*$|=>\s*$/.test(lines[0]);
  firstIndent = Math.max(0, restIndents[0] - (opensBlock ? unit : 0));
}

const minIndent = Math.min(firstIndent, ...restIndents);

const dedented = lines
  .map((line) => line.slice(Math.min(indentOf(line), minIndent)))
  .join("\n");

execSync("pbcopy", { input: dedented });
EOF

# Paste into the app that had focus before Raycast opened. When run from a
# hotkey its modifiers may still be held, turning Cmd+V into another shortcut,
# so wait (up to 2s) until shift/ctrl/option/cmd are all released
sleep 0.1
osascript -l JavaScript <<'JXA'
ObjC.import("AppKit");
const MODIFIERS = 0x1e0000; // shift | control | option | command
for (let i = 0; i < 100 && (Number($.NSEvent.modifierFlags) & MODIFIERS); i++) {
  delay(0.02);
}
Application("System Events").keystroke("v", { using: "command down" });
JXA
echo "Pasted"
