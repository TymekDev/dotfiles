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
alias cf='f() { cd $(find ${1:-.} -type d | fzf --height 60%) }; f' # [c]d [f]uzzy

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
# -- Path updates
# ------------------------------------------------------------------------------

# Defaults from .bashrc
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Adding Go to PATH
if [ -d "$HOME/go/bin" ]; then
    PATH="$PATH:$HOME/go/bin"
fi

if [ -d "/usr/local/go/bin" ]; then
    PATH="$PATH:/usr/local/go/bin"
fi

# Adding Tarsnap backup scripts to PATH
if [ -d "$HOME/.tarsnap/bin" ]; then
    PATH="$PATH:$HOME/.tarsnap/bin"
fi
