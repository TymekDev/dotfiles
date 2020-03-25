# Default stuff taken from Debian 10 -------------------------------------------

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# Custom configuration ---------------------------------------------------------

# Adding Go to PATH
if [ -d "/usr/local/go/bin" ]; then
    PATH="$PATH:/usr/local/go/bin"
fi

# Git aliases (for more details see .gitconfig)
alias gd="git diff --color-words"
alias gd2="git diff"
alias gf="git fetch"
alias gs="git status"

alias gg="git logg"
alias gg2="git logg2"
alias ggs="git loggs"
alias ggs2="git loggs2"
