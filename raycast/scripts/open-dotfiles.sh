#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Dotfiles
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🗂️
# @raycast.packageName Projects

# Documentation:
# @raycast.description Open the dotfiles project in VS Code
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

set -euo pipefail

target="$HOME/Documents/projects/dotfiles"

# Locate the `code` CLI even when Raycast runs with a minimal PATH
code_bin="$(command -v code || true)"
if [ -z "$code_bin" ]; then
  for candidate in \
    "/opt/homebrew/bin/code" \
    "/usr/local/bin/code" \
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"; do
    if [ -x "$candidate" ]; then
      code_bin="$candidate"
      break
    fi
  done
fi

if [ -z "$code_bin" ]; then
  echo "Could not find the 'code' command on PATH"
  exit 1
fi

if [ ! -d "$target" ]; then
  echo "Folder does not exist: $target"
  exit 1
fi

"$code_bin" "$target"
echo "Opened $target"
