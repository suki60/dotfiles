#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Awake
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ☀️
# @raycast.packageName System

# Documentation:
# @raycast.description Keep the Mac awake, even with the lid closed (pmset disablesleep 1)
# @raycast.author fran
# @raycast.authorURL https://github.com/fran

# Needs the passwordless rule in /etc/sudoers.d/pmset; -n fails instead of
# waiting for a password Raycast can't show
if ! sudo -n /usr/bin/pmset -a disablesleep 1 2>/dev/null; then
  echo "Missing sudo rule: run sudo visudo -f /etc/sudoers.d/pmset"
  exit 1
fi
