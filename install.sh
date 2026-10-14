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
link "$DOTFILES/vscode/tasks.json"       "$VSCODE/tasks.json"
link "$DOTFILES/global.code-snippets"    "$VSCODE/snippets/global.code-snippets"

installed="$(code --list-extensions)"
added=0

while read -r ext; do
  grep -qix "$ext" <<<"$installed" && continue
  code --install-extension "$ext"
  added=1
done < "$DOTFILES/vscode/extensions"

[[ $added -eq 1 ]] || echo "  skip  extensions (all installed)"

echo "→ Claude"
link "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
link "$DOTFILES/claude/CLAUDE.md"     "$HOME/.claude/CLAUDE.md"

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

echo "→ Node"
node_out="$(fnm install --lts 2>&1)" || { echo "$node_out"; exit 1; }
if grep -q "already installed" <<<"$node_out"; then
  echo "  skip  node (latest LTS already installed)"
else
  echo "$node_out"
fi
fnm default lts-latest
eval "$(fnm env --shell bash)"

if command -v ni >/dev/null; then
  echo "  skip  ni"
else
  npm i -g @antfu/ni
fi

echo ""
echo "Done."
