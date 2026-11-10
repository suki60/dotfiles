#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dock
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🚢
# @raycast.packageName System

# Documentation:
# @raycast.description Toggle Dock hiding on/off (same as the macOS "Turn Dock hiding on/off" shortcut)
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

# System Events applies it live, without restarting the Dock like
# `defaults write com.apple.dock autohide` + `killall Dock` would
osascript >/dev/null <<'APPLESCRIPT'
tell application "System Events"
  tell dock preferences to set autohide to not autohide
end tell
APPLESCRIPT
