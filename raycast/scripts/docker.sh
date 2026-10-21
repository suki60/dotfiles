#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Docker
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🐳
# @raycast.packageName Docker

# Documentation:
# @raycast.description Toggle the Docker Desktop dashboard (open, or hide if already focused)
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

# Docker not running yet: launch it, which opens the dashboard
if ! pgrep -xq "Docker Desktop"; then
  open -a "Docker"
  exit 0
fi

osascript <<'APPLESCRIPT'
tell application "System Events"
  tell process "Docker Desktop"
    if frontmost and visible and (count of windows) > 0 then
      set visible to false
    else
      click menu item "Go to the Dashboard" of menu 1 of menu bar item 1 of menu bar 2
      set frontmost to true
    end if
  end tell
end tell
APPLESCRIPT
