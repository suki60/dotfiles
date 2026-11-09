#!/bin/bash

# <swiftbar.title>Awake</swiftbar.title>
# <swiftbar.desc>Show whether Awake (pmset disablesleep) is on, with actions to switch it</swiftbar.desc>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>

# Refreshes every 10s (the "10s" in the file name). The actions reuse the
# Raycast scripts, which run pmset through the rule in /etc/sudoers.d/pmset.
SCRIPTS="$(cd "$(dirname "$0")/../raycast/scripts" && pwd)"

if pmset -g | grep -q "SleepDisabled[[:space:]]*1"; then
  echo " | sfimage=cup.and.heat.waves.fill"
  echo "---"
  echo "Awake: on (stays on with the lid closed)"
  echo "Turn off | bash=/usr/bin/sudo param1=-n param2=/usr/bin/pmset param3=-a param4=disablesleep param5=0 terminal=false refresh=true"
else
  echo " | sfimage=cup.and.heat.waves"
  echo "---"
  echo "Awake: off (sleeps normally)"
  echo "Turn on | bash=$SCRIPTS/awake.sh terminal=false refresh=true"
fi

echo "Sleep Now | bash=$SCRIPTS/sleep.sh terminal=false"
