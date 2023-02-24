#!/usr/bin/env bash
selected=$(cat ~/.local/share/cht.sh/* | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Query: " query

if grep -qs "$selected" ~/.local/share/cht.sh/languages.txt; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "curl -s cht.sh/$selected/$query | less -R"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less -R"
fi
