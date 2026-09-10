#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1"
  local dst="$2"

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "  skip  $dst"
    return
  fi

  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "  linked $dst → $src"
}

echo "Dotfiles: $DOTFILES"
echo ""

echo "→ Shell"
link "$DOTFILES/zshrc"       "$HOME/.zshrc"

echo "→ Starship"
link "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"

echo "→ VSCode"
VSCODE="$HOME/Library/Application Support/Code/User"
link "$DOTFILES/vscode/settings.json"    "$VSCODE/settings.json"
link "$DOTFILES/vscode/keybindings.json" "$VSCODE/keybindings.json"

echo "→ Cursor"
CURSOR="$HOME/Library/Application Support/Cursor/User"
link "$DOTFILES/cursor/settings.json"    "$CURSOR/settings.json"
link "$DOTFILES/cursor/keybindings.json" "$CURSOR/keybindings.json"

echo "→ Zed"
ZED="$HOME/.config/zed"
link "$DOTFILES/zed/settings.json" "$ZED/settings.json"
link "$DOTFILES/zed/keymap.json"   "$ZED/keymap.json"

echo "→ Claude"
link "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"

echo "→ Ghostty"
link "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

echo "→ nnn"
NNN_PLUGINS="$HOME/.config/nnn/plugins"

for plugin in "$DOTFILES"/nnn/plugins/*; do
  link "$plugin" "$NNN_PLUGINS/$(basename "$plugin")"
done

echo "→ Raycast scripts"
SCRIPTS="$HOME/.scripts"

for script in "$DOTFILES"/raycast/scripts/*; do
  link "$script" "$SCRIPTS/$(basename "$script")"
done

echo ""
echo "Done."
