#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Awake
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ☕️
# @raycast.packageName System

# Documentation:
# @raycast.description Toggle Awake: keep the Mac on even with the lid closed (pmset disablesleep), or let it sleep again
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

if pmset -g | grep -q "SleepDisabled[[:space:]]*1"; then
  value=0
else
  value=1
fi

# Needs the passwordless rule in /etc/sudoers.d/pmset; -n fails instead of
# waiting for a password Raycast can't show
if ! sudo -n /usr/bin/pmset -a disablesleep "$value" 2>/dev/null; then
  echo "Missing sudo rule: run sudo visudo -f /etc/sudoers.d/pmset"
  exit 1
fi

# Update the SwiftBar indicator right away instead of on its next refresh.
# Only when it's running: launching SwiftBar through this URL crashes it.
if pgrep -xq SwiftBar; then
  open -g "swiftbar://refreshplugin?name=awake"
fi
