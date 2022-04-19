abbr --add ga   git add
abbr --add gap  git add -p
abbr --add gb   git branch
abbr --add gc   git commit
abbr --add gca  git commit --amend --no-edit
abbr --add gcae git commit --amend
abbr --add gcam git commit -am
abbr --add gcb  git checkout -b
abbr --add gcm  git commit -m
abbr --add gco  git checkout
abbr --add gcp  git cherry-pick
abbr --add gcpm git commit -pm
abbr --add gd   git diff
abbr --add gds  git diff --staged
abbr --add gf   git fetch
abbr --add gg   git g
abbr --add ggs  git gs
abbr --add gl   git pull
abbr --add glg  git log
abbr --add gm   git merge
abbr --add gp   git push
abbr --add gs   git status
abbr --add gwt  git worktree

alias g  git
alias r  radian
alias nv nvim

bind \cs "stty sane; tmux-sessionizer"
bind \cg "stty sane; nvim +Git +only"
bind \cj accept-autosuggestion execute
bind \ck forward-word
bind \cp "stty sane; nvim +GFiles"
bind \c_ "stty sane; tmux-cht.sh"

set -x EDITOR nvim

fish_add_path ~/.local/bin
fish_add_path ~/.npm-global/bin
fish_add_path ~/.tarsnap/bin
fish_add_path ~/go/bin
