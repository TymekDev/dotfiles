# ------------------------------------------------------------------------------
# -- ZSH & oh-my-zsh
# ------------------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"
CASE_SENSITIVE="true"
plugins=(git fzf fzf-tab)

source $ZSH/oh-my-zsh.sh


# ------------------------------------------------------------------------------
# -- Aliases
# ------------------------------------------------------------------------------

# Basics
alias cf="f() { cd $(find ${1:-.} -type d | fzf --height 60%) }; f" # [c]d [f]uzzy
alias cb="cd $OLDPWD"                                               # [c]d [b]ack

# Git
alias gd="git diff"           # [g]it [d]iff
alias gds="git diff --staged" # [g]it [d]iff [s]taged
alias gf="git fetch"          # [g]it [f]etch
alias gg="git g"              # [g]it [g]raph
alias ggs="git gs"            # [g]it [g]raph [s]ingle
alias gs="git status"         # [g]it [s]tatus

# Other
alias R=radian
alias r=R


# ------------------------------------------------------------------------------
# -- PATH updates
# ------------------------------------------------------------------------------

PATHS=(
  "$HOME/.local/bin"
  "$HOME/.tarsnap/bin"
  "$HOME/bin"
  "$HOME/go/bin"
  "/usr/local/go/bin"
)

for p in $PATHS; do
  if [ -d $p ]; then
    PATH=$p:$PATH
  fi
done

