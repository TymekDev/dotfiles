# ------------------------------------------------------------------------------
# -- General
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

alias gf="git fetch"
alias gs="git status"

alias gd="git diff"
alias gds="git diff --staged"

alias gg="git lg"
alias gg2="git lg2"
alias ggs="git lgs"
alias ggs2="git lgs2"

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
