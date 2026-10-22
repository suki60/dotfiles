# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# starship
eval "$(starship init zsh)"

# folders
alias hom="cd ~"
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias doc="cd ~/Documents"
alias wk="cd ~/Documents/work"
alias box="cd ~/Documents/box"
alias rep="cd ~/Documents/repos"

# repos
alias dot="cd ~/Documents/repos/dotfiles"
alias pf="cd ~/Documents/repos/portfolio"
alias cv="cd ~/Documents/repos/cv"
alias wed="cd ~/Documents/repos/wedding"

# brew
alias bu="brew update && brew upgrade && brew cleanup"
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
export HOMEBREW_NO_ENV_HINTS=1

# git
gr() {
  git commit --fixup="$1" && GIT_SEQUENCE_EDITOR=true git rebase -i --autostash --autosquash "$1~1"
}

gc() {
  gh repo list "$1" --limit 500 --json nameWithOwner -q '.[].nameWithOwner' \
    | fzf | xargs -r gh repo clone
}

# claude
alias k="claude"
alias kp="k -p"
alias kr="k --resume"
alias kc="k --continue"
alias kcp="k --continue -p"
alias ka="k agents"
alias ks="$HOME/Documents/repos/dotfiles/bin/ksessions"
export BASH_DEFAULT_TIMEOUT_MS="7200000"
export BASH_MAX_TIMEOUT_MS="7200000"

# vscode
alias c="code ."

# ni
alias nx="nlx"
alias nrs="nr start"
alias nrb="nx build"
alias b="nx biome"
alias bl="b lint"
alias bf="b format"
alias bc="b check"
alias bcw="b check --write"

# vercel
alias v="vercel"

# docker 
alias d="docker"
alias dc="docker compose"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

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

export NNN_PLUG='c:vscode;z:zed;f:finder;p:pbcopy;k:claude'
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/suki60/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
