# General ----------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"
CASE_SENSITIVE="true"
plugins=(git fzf fzf-tab)

source $ZSH/oh-my-zsh.sh


# Aliases ----------------------------------------------------------------------

# Git (for more details see .gitconfig)
alias gd="git diff --color-words"
alias gd2="git diff"
alias gf="git fetch"
alias gs="git status"

alias glb="git lb"
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


# Exports ----------------------------------------------------------------------

# Export to make the UnityEngine autocomplete work with omnisharp-vim
export FrameworkPathOverride=/lib/mono/4.5

# ls and tab completion color fix for Windows dirs.
LS_COLORS=$LS_COLORS:'ow=01;34:'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Clipboard sharing between Windows and WSL via VcXsrv.
export DISPLAY=localhost:0.0
