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

abbr --add ta tmux attach-session
abbr --add tls tmux list-sessions

abbr --add aia ANTHROPIC_API_KEY=\(op read \$ANTHROPIC_API_KEY\)
abbr --add aio OPENAI_API_KEY=\(op read \$OPENAI_API_KEY\)

alias g  git
alias k  kubectl
alias r  radian
alias ls "eza --git --group-directories-first --time-style long-iso"
alias nv nvim

bind \cs "stty sane; tmux-sessionizer"
bind \cj accept-autosuggestion execute
bind \ck forward-word
bind \cf "stty sane; nvim -c 'normal ' -c 'startinsert'"
bind \cg "stty sane; nvim -c 'normal '"
# FEAT: make this update automatic
bind \et update_theme
bind \en "fish_commandline_prepend 'nvim (' && fish_commandline_append ' )'"

set -x EDITOR nvim
set -x TZ 'Europe/Warsaw'
set -x N_PREFIX ~/.local/share/n
set -x BUN_INSTALL ~/.local/share/bun
set -x OPENAI_API_KEY "op://Private/kjoegzrmj4gkwvaiugch7kac4i/credential"
set -x AI_DEVS_API_KEY "op://Private/lj32f6k4u4uuypiu53hpslya4i/credential"
set -x ANTHROPIC_API_KEY "op://Private/cdfzv6cs2k5i2uuyssibaihdty/credential"

if test (uname) = "Darwin"
  set -x SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
end

if test -f /etc/fish/conf.d/codespaces.fish
  set -gx SHELL_LOGGED_IN true
  source /etc/fish/conf.d/codespaces.fish
end

# homebrew
set -l BREW_DIR
if test (uname) = "Darwin"
  set BREW_DIR /opt/homebrew
else if test (uname) = "Linux"
  set BREW_DIR /home/linuxbrew/.linuxbrew
end

if test -n "$BREW_DIR"
  set -x SHELL $BREW_DIR/bin/fish
  eval ($BREW_DIR/bin/brew shellenv)

  set -l CURL_PATH $BREW_DIR/opt/curl
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

# pipx
if test (uname) = "Linux"
  set -gx PIPX_HOME /usr/local/py-utils
  fish_add_path $PIPX_HOME/bin
end
# pipx end

fish_add_path ~/.cargo/bin
fish_add_path ~/.npm-global/bin
fish_add_path ~/go/bin
fish_add_path ~/Library/Python/3.9/bin
fish_add_path /usr/local/go/bin
fish_add_path --move ~/.local/bin
fish_add_path --move ~/.local/share/bob/nvim-bin
fish_add_path --move $BUN_INSTALL/bin
fish_add_path --move ~/.local/share/n/bin

fzf --fish | source

starship init fish | source

update_theme
