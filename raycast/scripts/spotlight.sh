#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Spotlight
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔍
# @raycast.packageName System

# Documentation:
# @raycast.description Show Spotlight search
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

# Spotlight has no command or URL to open it, so press its system shortcut
# (⌘F4, key code 118); keep "Show Spotlight search" enabled in System Settings
osascript >/dev/null <<'APPLESCRIPT'
tell application "System Events" to key code 118 using command down
APPLESCRIPT
