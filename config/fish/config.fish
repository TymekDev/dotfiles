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
abbr --add grb  git rebase --interactive
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

abbr --add jc  jj commit
abbr --add jcm jj commit -m
abbr --add jd  jj diff
abbr --add jdl jj diff -r @- # jj diff last
abbr --add js  jj status

alias g  git
alias ls "eza --git --group-directories-first --time-style long-iso"
alias nv nvim

bind \cj accept-autosuggestion execute
bind \ck forward-word
bind \cf "stty sane; nvim -c 'normal ' -c 'startinsert'"
bind \cg "stty sane; nvim -c 'normal '"
bind \en "fish_commandline_prepend 'nvim (' && fish_commandline_append ' )'"

set -x EDITOR nvim
set -x TZ 'Europe/Warsaw'
set -x BUN_INSTALL ~/.local/share/bun

if test (uname) = "Darwin"
  set -x SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
end

if test -f /etc/fish/conf.d/codespaces.fish
  set -gx SHELL_LOGGED_IN true
  source /etc/fish/conf.d/codespaces.fish

  set -l BREW_DIR /home/linuxbrew/.linuxbrew
  if test -n "$BREW_DIR"
    set -x SHELL $BREW_DIR/bin/fish
    eval ($BREW_DIR/bin/brew shellenv)

    set -l CURL_PATH $BREW_DIR/opt/curl
    if test -d $CURL_PATH
      fish_add_path $CURL_PATH/bin
      set -xp MANPATH $CURL_PATH/share/man
    end
  end
end

# pipx
if test (uname) = "Linux"
  set -gx PIPX_HOME /usr/local/py-utils
  fish_add_path $PIPX_HOME/bin
end
# pipx end

fish_add_path --move ~/.local/bin
fish_add_path --move $BUN_INSTALL/bin

fzf --fish | source

starship init fish | source

update_theme
