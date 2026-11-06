# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# starship
eval "$(starship init zsh)"

# folders
alias h="cd ~"
alias dt="cd ~/Desktop"
alias dw="cd ~/Downloads"
alias doc="cd ~/Documents"
alias wk="cd ~/Documents/work"
alias box="cd ~/Documents/box"
alias r="cd ~/Documents/repos"
alias kpj="cd ~/.claude/projects"

# repos
alias dot="cd ~/Documents/repos/dotfiles"
alias pf="cd ~/Documents/repos/portfolio"
alias cv="cd ~/Documents/repos/cv"
alias wed="cd ~/Documents/repos/wedding"
alias wik="cd ~/Documents/repos/offwik"

# brew
alias bu="brew update && brew upgrade && brew cleanup"
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
export HOMEBREW_NO_ENV_HINTS=1

# git
alias g="git"
alias gp="g pull"
gr() {
  git commit --fixup="$1" && GIT_SEQUENCE_EDITOR=true git rebase -i --autostash --autosquash "$1~1"
}

gc() {
  gh repo list "$1" --limit 500 --json nameWithOwner -q '.[].nameWithOwner' \
    | fzf | xargs -r gh repo clone
}

# folders: pick a subfolder of the current dir with fzf and cd into it
f() {
  local dir

  dir="$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; \
    | sort -f | fzf --reverse --prompt='folder> ' --query="$1" --select-1)" || return
  cd "$dir"
}

# repos: pick one with fzf and cd into it
fr() {
  local root="$HOME/Documents/repos"
  local repo

  repo="$(find "$root" -mindepth 1 -maxdepth 1 -type d -not -name '.*' -exec basename {} \; \
    | sort -f | fzf --reverse --prompt='repo> ' --query="$1" --select-1)" || return
  cd "$root/$repo"
}

# home: pick a folder in ~ with fzf and cd into it
fh() {
  local dir

  dir="$(find "$HOME" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; \
    | sort -f | fzf --reverse --prompt='home> ' --query="$1" --select-1)" || return
  cd "$HOME/$dir"
}

# claude
alias k="claude"
alias kr="k --resume"
alias kc="k --continue"
alias ka="k agents"

# kp what is foo? -> one prompt, no quotes; noglob keeps ? and * literal
_kp() { claude -p --no-session-persistence --model haiku "$*" }
alias kp="noglob _kp"
alias ku="_kp /usage"

# claude in ~ from anywhere; the subshell keeps your current dir
kh() { (cd "$HOME" && claude "$@") }

alias ks="$HOME/Documents/repos/dotfiles/bin/ksessions"
export BASH_DEFAULT_TIMEOUT_MS="7200000"
export BASH_MAX_TIMEOUT_MS="7200000"

# codex
alias x="codex"
alias xr="x resume"
alias xc="x resume --last"
alias xa="x agents"

# xp what is foo? -> one prompt, no quotes; noglob keeps ? and * literal
_xp() { codex exec --ephemeral "$*" }
alias xp="noglob _xp"

alias xs="$HOME/Documents/repos/dotfiles/bin/csessions"

# codex in ~ from anywhere; the subshell keeps your current dir
xh() { (cd "$HOME" && codex "$@") }

# antigravity
alias a="agy"
alias ac="a --continue"
alias aa="a agents"

# ap what is foo? -> one prompt, no quotes; noglob keeps ? and * literal
_ap() { agy --print "$*" }
alias ap="noglob _ap"

alias as="$HOME/Documents/repos/dotfiles/bin/asessions"

# antigravity in ~ from anywhere; the subshell keeps your current dir
ah() { (cd "$HOME" && agy "$@") }

# vscode: open the given path, or the current folder
c() {
  code "${@:-.}"
}

# finder: open the given path, or the current folder
o() {
  open "${@:-.}"
}

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
alias dce="dc exec"
alias dcu="dc up"
alias dcd="dc down"

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

export NNN_PLUG='c:vscode;f:finder;p:pbcopy;a:pbpath;k:claude'
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# zsh
alias szsh="source ~/.zshrc"
copy-last-output() {
  local cmd=$(fc -ln -1)

  # Show the message now: zle only redraws after the widget returns.
  zle -M "Running: $cmd ..."
  zle -R
  eval "$cmd" 2>&1 | pbcopy
  zle -M "Copied output of: $cmd"
}

zle -N copy-last-output
bindkey '^[a' copy-last-output

clear-line-and-message() {
  zle kill-whole-line
  zle -M ""
}

zle -N clear-line-and-message
bindkey '^U' clear-line-and-message

run-and-copy-output() {
  [[ -z $BUFFER ]] && return
  _copy_output_cmd=$BUFFER
  BUFFER="{ $BUFFER; } |& tee >(pbcopy)"
  zle accept-line
}

# Save the original command to history instead of the tee wrapper.
_copy_output_history() {
  [[ -z $_copy_output_cmd ]] && return 0
  print -s -- "$_copy_output_cmd"
  unset _copy_output_cmd
  return 1
}

zle -N run-and-copy-output
bindkey '^[^M' run-and-copy-output
autoload -Uz add-zsh-hook
add-zsh-hook zshaddhistory _copy_output_history

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/suki60/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
