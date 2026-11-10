#!/bin/bash

# <swiftbar.title>Awake</swiftbar.title>
# <swiftbar.desc>Show whether Awake (pmset disablesleep) is on, with an action to toggle it</swiftbar.desc>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>

# Refreshes every 10s (the "10s" in the file name). The action reuses the
# Raycast toggle, which runs pmset through the rule in /etc/sudoers.d/pmset.
AWAKE="$(cd "$(dirname "$0")/../raycast/scripts" && pwd)/awake.sh"

if pmset -g | grep -q "SleepDisabled[[:space:]]*1"; then
  echo " | sfimage=storefront.fill"
  echo "---"
  echo "Awake: on (stays on with the lid closed)"
  echo "Turn off | bash=$AWAKE terminal=false refresh=true"
else
  echo " | sfimage=storefront"
  echo "---"
  echo "Awake: off (sleeps normally)"
  echo "Turn on | bash=$AWAKE terminal=false refresh=true"
fi
