#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sleep
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌙
# @raycast.packageName System

# Documentation:
# @raycast.description Undo Awake (pmset disablesleep 0) and put the Mac to sleep
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

# Sleep is refused while disablesleep is on, so turn it off first. Needs the
# passwordless rule in /etc/sudoers.d/pmset; -n fails instead of waiting for a
# password Raycast can't show
if ! sudo -n /usr/bin/pmset -a disablesleep 0 2>/dev/null; then
  echo "Missing sudo rule: run sudo visudo -f /etc/sudoers.d/pmset"
  exit 1
fi

open -g "swiftbar://refreshplugin?name=awake"
