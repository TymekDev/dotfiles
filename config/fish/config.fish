abbr --add ga   git add
abbr --add gab  git absorb
abbr --add gap  git add -p
abbr --add gb   git branch
abbr --add gc   git commit
abbr --add gca  git commit --amend
abbr --add gcam git commit -am
abbr --add gce  git commit --amend --no-edit
abbr --add gcf  git commit --fixup
abbr --add gcm  git commit -m
abbr --add gcp  git cherry-pick
abbr --add gcw  git commit --amend --only
abbr --add gd   git diff
abbr --add gds  git diff --staged
abbr --add gec  git ec # TODO: change this to fish function or else gitsigns in Neovim breaks
abbr --add gem  git em
abbr --add gf   git fetch
abbr --add gg   git g
abbr --add ggf  git gf
abbr --add ggs  git gs
abbr --add gl   git pull
abbr --add glg  git log
abbr --add gm   git merge
abbr --add gmt  git mergetool
abbr --add gp   git push
abbr --add gpf  git push --force-with-lease
abbr --add gpr  gh pr view --web
abbr --add grb  git rebase --autostash --interactive
abbr --add grbc git rebase --continue
abbr --add grs  git restore
abbr --add grsp git restore -p
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
alias r  radian
alias ls "eza --git --group-directories-first --time-style long-iso"
alias nv nvim

bind \cs "stty sane; tmux-sessionizer"
bind \cj accept-autosuggestion execute
bind \ck forward-word
bind \cf "stty sane; nvim +'Telescope find_files'"
bind \cg "stty sane; nvim +'Telescope live_grep'"
# FEAT: make this update automatic
bind \et "update-theme-fish"
bind \en "fish_commandline_prepend 'nvim (' && fish_commandline_append ' )'"

set -x EDITOR nvim
set -x N_PREFIX ~/.local/share/n
if test (uname) = "Darwin"
  set -x SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
end

fish_add_path ~/.cargo/bin
fish_add_path ~/.npm-global/bin
fish_add_path ~/go/bin
fish_add_path ~/Library/Python/3.9/bin
fish_add_path /usr/local/go/bin
fish_add_path --move ~/.local/bin
fish_add_path --move ~/.local/share/bob/nvim-bin
fish_add_path --move ~/.local/share/n/bin

# homebrew
if test (uname) = "Darwin"
  set -x SHELL /opt/homebrew/bin/fish
  eval "$(/opt/homebrew/bin/brew shellenv)"
  set -l CURL_PATH /opt/homebrew/opt/curl
  if test -d $CURL_PATH
    fish_add_path $CURL_PATH/bin
    set -xp MANPATH $CURL_PATH/share/man
  end
end
# homebrew end

# pnpm
if test (uname) = "Darwin"
  set -gx PNPM_HOME ~/Library/pnpm
  fish_add_path $PNPM_HOME
end
# pnpm end

update-theme-fish

starship init fish | source
