#!/usr/bin/env bash

# Stop on any error, unset variable or failed pipe.
set -euo pipefail

# Absolute path of this repo, wherever the script is run from.
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Symlink src → dst, skipping it if the link already points there.
link() {
  local src="$1"
  local dst="$2"

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "  skip  $dst"
    return
  fi

  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "  linked $dst → $src"
}

echo "Dotfiles: $DOTFILES"
echo ""

# zsh config.
echo "→ Shell"
link "$DOTFILES/zshrc"       "$HOME/.zshrc"

# Prompt theme.
echo "→ Starship"
link "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"

# Editor settings, keybindings, tasks and snippets.
echo "→ VSCode"
VSCODE="$HOME/Library/Application Support/Code/User"
link "$DOTFILES/vscode/settings.json"    "$VSCODE/settings.json"
link "$DOTFILES/vscode/keybindings.json" "$VSCODE/keybindings.json"
link "$DOTFILES/vscode/tasks.json"       "$VSCODE/tasks.json"
link "$DOTFILES/global.code-snippets"    "$VSCODE/snippets/global.code-snippets"

# Install each extension listed in vscode/extensions that's missing.
installed="$(code --list-extensions)"
added=0

while read -r ext; do
  grep -qix "$ext" <<<"$installed" && continue
  code --install-extension "$ext"
  added=1
done < "$DOTFILES/vscode/extensions"

[[ $added -eq 1 ]] || echo "  skip  extensions (all installed)"

# Claude Code settings.
echo "→ Claude"
link "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
link "$DOTFILES/claude/keybindings.json" "$HOME/.claude/keybindings.json"

# Shared global instructions and skills for Claude Code, Codex and agy.
# Each pair is the instructions file and the skills folder the tool reads.
echo "→ Agents"
for pair in \
  "$HOME/.claude/CLAUDE.md:$HOME/.claude/skills" \
  "$HOME/.codex/AGENTS.md:$HOME/.agents/skills" \
  "$HOME/.gemini/GEMINI.md:$HOME/.gemini/config/skills"; do
  link "$DOTFILES/agents/AGENTS.md" "${pair%%:*}"

  for skill in "$DOTFILES"/agents/skills/*/; do
    skill="${skill%/}"
    link "$skill" "${pair#*:}/$(basename "$skill")"
  done
done

# Terminal config.
echo "→ Ghostty"
link "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# File manager plugins.
echo "→ nnn"
NNN_PLUGINS="$HOME/.config/nnn/plugins"

for plugin in "$DOTFILES"/nnn/plugins/*; do
  link "$plugin" "$NNN_PLUGINS/$(basename "$plugin")"
done

# Script commands, read by Raycast from ~/.scripts.
echo "→ Raycast scripts"
SCRIPTS="$HOME/.scripts"

for script in "$DOTFILES"/raycast/scripts/*; do
  link "$script" "$SCRIPTS/$(basename "$script")"
done

# Latest Node LTS via fnm; only print fnm's output when it did something.
echo "→ Node"
node_out="$(fnm install --lts 2>&1)" || { echo "$node_out"; exit 1; }

if grep -q "already installed" <<<"$node_out"; then
  echo "  skip  node (latest LTS already installed)"
else
  echo "$node_out"
fi

# Make it the default, and put it on PATH for the rest of this script.
fnm default lts-latest
eval "$(fnm env --shell bash)"

# ni: one command for npm/pnpm/yarn/bun.
if command -v ni >/dev/null; then
  echo "  skip  ni"
else
  npm i -g @antfu/ni
fi

# Each vscode/<ext>/ folder with a package.json is a local extension.
# VSCode expects it at ~/.vscode/extensions/<publisher>.<name>-<version>.
echo "→ VSCode local extensions"
for pkg in "$DOTFILES"/vscode/*/package.json; do
  id="$(node -p "const p = require('$pkg'); p.publisher + '.' + p.name + '-' + p.version")"
  link "$(dirname "$pkg")" "$HOME/.vscode/extensions/$id"
done

# Each raycast/extensions/<ext>/ is a local Raycast extension. `ray develop`
# is the only way to register one: it builds into ~/.config/raycast/extensions
# and keeps watching, so a watcher stops it once the build lands.
echo "→ Raycast extensions"
for dir in "$DOTFILES"/raycast/extensions/*/; do
  dir="${dir%/}"
  name="$(basename "$dir")"
  built="$HOME/.config/raycast/extensions/$name/package.json"

  # Skip it if the build is newer than every source file.
  if [[ -f "$built" ]] && [[ -z "$(find "$dir/src" "$dir/package.json" -newer "$built")" ]]; then
    echo "  skip  $name (already built)"
    continue
  fi

  [[ -d "$dir/node_modules" ]] || npm ci --prefix "$dir"
  open -ga Raycast

  # Remove the old build so its reappearance means a fresh one.
  rm -f "$built"
  # Send ray develop a Ctrl+C once the build appears, or after 60s.
  (
    for _ in {1..60}; do
      [[ -f "$built" ]] && break
      sleep 1
    done
    pkill -INT -f "$dir/node_modules/.bin/ray develop"
  ) &
  watcher=$!

  (cd "$dir" && exec ./node_modules/.bin/ray develop) || true
  kill "$watcher" 2>/dev/null || true

  if [[ -f "$built" ]]; then
    echo "  built $name"
  else
    echo "  FAILED $name, run 'npm run dev' in $dir"
  fi
done

echo "→ macOS"

# Free ⌘M: no menu item claims it, so it never minimizes.
defaults write -g NSUserKeyEquivalents -dict-add "Minimize" "\0"

# ⌥⌘T opens Chrome's Task Manager (no default shortcut on Mac).
# Chrome picks it up after a full quit (⌘Q) and reopen.
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Task Manager" "@~t"

# Hide the Dock for good: auto-hide with a 1000s reveal delay.
# Restart the Dock only when the setting changes, to avoid a flicker.
if [[ "$(defaults read com.apple.dock autohide-delay 2>/dev/null)" == "1000" ]]; then
  echo "  skip  dock (already hidden)"
else
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock autohide-delay -float 1000
  killall Dock
fi

echo ""
echo "Done."
