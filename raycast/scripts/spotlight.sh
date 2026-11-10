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
# (⌘F4, key code 118); keep "Show Spotlight search" enabled in System Settings.
# The key events set their own modifiers, so keys still held from the Raycast
# hotkey don't mix in
osascript -l JavaScript >/dev/null <<'JXA'
ObjC.import('CoreGraphics')
const flags = 0x100000 | 0x800000 // ⌘ + Fn (F-keys carry the Fn flag)
for (const isDown of [true, false]) {
  const e = $.CGEventCreateKeyboardEvent(null, 118, isDown)
  $.CGEventSetFlags(e, flags)
  $.CGEventPost($.kCGHIDEventTap, e)
}
JXA
