# General ----------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"
CASE_SENSITIVE="true"
plugins=(git fzf fzf-tab)

source $ZSH/oh-my-zsh.sh


# Aliases ----------------------------------------------------------------------

# Git (for more details see .gitconfig)
alias gf="git fetch"
alias gs="git status"
alias glb="git lb"

alias gd="git diff --color-words"
alias gd2="git diff"
alias gds="git diff --color-words --staged"
alias gds2="git diff --staged"

alias gg="git logg"
alias gg2="git logg2"
alias ggs="git loggs"
alias ggs2="git loggs2"


# Path updates -----------------------------------------------------------------

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