abbr --add ga   git add
abbr --add gap  git add -p
abbr --add gb   git branch
abbr --add gc   git commit
abbr --add gca  git commit --amend
abbr --add gcam git commit -am
abbr --add gcb  git checkout -b
abbr --add gce  git commit --amend --no-edit
abbr --add gcm  git commit -m
abbr --add gco  git checkout
abbr --add gcp  git cherry-pick
abbr --add gcpm git commit -pm
abbr --add gd   git diff
abbr --add gds  git diff --staged
abbr --add gec  git ec # TODO: change this to fish function or else gitsigns in Neovim breaks
abbr --add gem  git em
abbr --add gf   git fetch
abbr --add gg   git g
abbr --add ggs  git gs
abbr --add gl   git pull
abbr --add glg  git log
abbr --add gm   git merge
abbr --add gp   git push
abbr --add gpf  git push --force-with-lease
abbr --add gpr  gh pr view --web
abbr --add grb  git rebase --autostash --interactive
abbr --add grbc git rebase --continue
abbr --add grs  git restore
abbr --add grss git restore --staged
abbr --add gs   git status
abbr --add gst  git stash
abbr --add gstl git stash list
abbr --add gstp git stash pop
abbr --add gsts git stash show -p
abbr --add gsw  git switch
abbr --add gwt  git worktree

abbr --add ta tmux attach-session

alias g  git
alias k  kubectl
alias ls "exa --git --group-directories-first --time-style long-iso"
alias nv nvim

bind \cs "stty sane; tmux-sessionizer"
bind \cj accept-autosuggestion execute
bind \ck forward-word
bind \cf "stty sane; nvim +'Telescope find_files'"
bind \cg "stty sane; nvim +'Telescope live_grep'"

set -x EDITOR nvim
set -x GOKRAZY_PARENT_DIR ~/personal
set -x GOKRAZY_INSTANCE gokrazy
set -x GOPRIVATE github.com/livechat
set -x N_PREFIX ~/.local/share/n

fish_add_path ~/.cargo/bin
fish_add_path ~/.npm-global/bin
fish_add_path ~/go/bin
fish_add_path /usr/local/go/bin
fish_add_path --move ~/.local/bin

# homebrew
if test (uname) = "Darwin"
  set -x SHELL /opt/homebrew/bin/fish
  eval "$(/opt/homebrew/bin/brew shellenv)"
end
# homebrew end

# pnpm
set -gx PNPM_HOME "/Users/tymek/Library/pnpm"
fish_add_path $PNPM_HOME
# pnpm end

# tokyonight
set -l THEME_PATH $HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/fish/tokyonight_storm.fish
if test -e $THEME_PATH
  source $THEME_PATH
end
# tokyonight end
