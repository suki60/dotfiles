#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Color Filters
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎨
# @raycast.packageName System

# Documentation:
# @raycast.description Show Accessibility controls to toggle color filters
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

# Accessibility controls have no command or URL to open them, so press their
# system shortcut (⌘F6, key code 97); keep "Show Accessibility controls"
# enabled in System Settings
osascript >/dev/null <<'APPLESCRIPT'
tell application "System Events" to key code 97 using command down
APPLESCRIPT
