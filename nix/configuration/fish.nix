{ pkgs, ... } :
{
  users.users.tymek.shell = pkgs.fish;

  programs.fish = {
    enable = true;
    shellAbbrs = {
      ga    = "git add";
      gab   = "git absorb";
      gap   = "git add -p";
      gb    = "git branch";
      gc    = "git commit";
      gca   = "git commit --amend";
      gcam  = "git commit -am";
      gce   = "git commit --amend --no-edit";
      gcf   = "git commit --fixup";
      gcm   = "git commit -m";
      gcp   = "git cherry-pick";
      gcw   = "git commit --amend --only";
      gd    = "git diff";
      gds   = "git diff --staged";
      gec   = "git ec"; # TODO: change this to fish function or else gitsigns in Neovim breaks
      gem   = "git em";
      gf    = "git fetch";
      gg    = "git g";
      ggf   = "git gf";
      ggs   = "git gs";
      gl    = "git pull";
      glg   = "git log";
      gm    = "git merge";
      gmt   = "git mergetool";
      gp    = "git push";
      gpf   = "git push --force-with-lease";
      gpr   = "gh pr view --web";
      grb   = "git rebase --autostash --interactive";
      grbc  = "git rebase --continue";
      grs   = "git restore";
      grsp  = "git restore -p";
      grss  = "git restore --staged";
      gs    = "git status";
      gst   = "git stash";
      gstl  = "git stash list";
      gstp  = "git stash pop";
      gsts  = "git stash show -p";
      gsw   = "git switch";
      gwt   = "git worktree";

      ta  = "tmux attach-session";
      tls = "tmux list-sessions";
    };

    shellAliases = {
      nv = "nvim";
    };

    shellInit = ''
      bind \cs "stty sane; tmux-sessionizer"
      bind \cj accept-autosuggestion execute
      bind \ck forward-word
      bind \cf "stty sane; nvim -c 'normal ' -c 'startinsert'"
      bind \cg "stty sane; nvim -c 'normal '"

      fish_add_path --move ~/.local/bin

      # Start hyprland automatically on tty1 (if it's not running already)
      if not set -q HYPRLAND_INSTANCE_SIGNATURE && uwsm check may-start
        exec uwsm start default
      end
    '';
  };
}
