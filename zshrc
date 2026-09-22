# starship
eval "$(starship init zsh)"

# folders
alias hom="cd ~"
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias doc="cd ~/Documents"
alias wk="cd ~/Documents/work"
alias box="cd ~/Documents/box"
alias pg="cd ~/Documents/playground"
alias pj="cd ~/Documents/projects"

# repos
alias wp="cd ~/Documents/projects/whitepepper"
alias dot="cd ~/Documents/projects/dotfiles"
alias pf="cd ~/Documents/projects/portfolio"
alias cv="cd ~/Documents/projects/cv"

# claude
alias k="claude"
alias kp="k -p"
alias kc="k --continue"
alias kcp="k --continue -p"

# vscode
alias c="code"
alias czsh="c ~/.zshrc"
alias cdot="c ~/Documents/projects/dotfiles"
alias ccl="c ~/.claude"

# npm
alias n="npm"
alias ni="n i"
alias nr="n run"

# pnpm
alias p="pnpm"
alias pr="p run"

# yarn
alias y="yarn"
alias yr="y run"

# vercel
alias v="vercel"

# biome
alias b="biome"
alias bl="b lint"
alias blo="b lint --only"
alias bll="b lint --diagnostic-level"
alias blw="b lint --diagnostic-level warn"
alias ble="b lint --diagnostic-level error"
alias blwo="b lint --diagnostic-level warn --only"
alias bleo="b lint --diagnostic-level error --only"
alias bf="b format"

# git
alias g="git"
alias gc="git checkout"
alias gf="git fetch"
alias gb="git rebase -i"
alias gbm="git rebase -i origin/main"
alias gr="git reset --hard"
alias grm="git reset --hard origin/main"
alias gcp="git cherry-pick"
alias gcl="git clone"

# docker 
alias d="docker"
alias dc="docker compose"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# nnn
m () {
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # cd on quit every time. To cd only when quitting with ^G, remove "export"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

export NNN_PLUG='c:vscode;z:zed;f:finder'
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# local bin
export PATH="$HOME/.local/bin:$PATH"

# helpers
cm() {
  local encoded=$(pwd | sed 's|/|-|g')
  local memory_dir="$HOME/.claude/projects/${encoded}/memory"
  if [ -d "$memory_dir" ]; then
    code "$memory_dir"
  else
    echo "No memory directory found for: $(pwd)"
    echo "Expected: $memory_dir"
  fi
}

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
