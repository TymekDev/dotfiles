# TODO: is there a better way to use fish funtions than relying on them being globally available?
{
  config,
  pkgs,
  lib,
  ...
}:
let
  hasFzfGit = config.programs.fzf.enable;
in
{

  xdg.configFile."fish/conf.d/fzf-git.fish".source =
    lib.mkIf hasFzfGit "${pkgs.fzf-git-sh}/share/fzf-git-sh/fzf-git.fish";

  # TODO: move to nix/pkgs/are-we-dark-yet.nix and install it (so it's available to Neovim)
  home.file.".local/bin/are-we-dark-yet".source = ../../local/bin/are-we-dark-yet;

  programs.fish = {
    enable = true;

    shellAbbrs = {
      ga = "git add";
      gab = "git absorb";
      gap = "git add -p";
      gb = "git branch";
      gc = "git commit";
      gca = "git commit --amend";
      gcam = "git commit -am";
      gce = "git commit --amend --no-edit";
      gcf = "git commit --fixup";
      gcm = "git commit -m";
      gcp = "git cherry-pick";
      gcw = "git commit --amend --only";
      gd = "git diff";
      gds = "git diff --staged";
      gf = "git fetch";
      gg = if hasFzfGit then "__fzf_git_sh hashes" else "git g";
      ggf = "git gf";
      ggs = "git gs";
      gl = "git pull";
      glg = "git log";
      gm = "git merge";
      gmt = "git mergetool";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gpr = "gh pr view --web";
      grb = "git rebase --autostash --interactive";
      grbc = "git rebase --continue";
      grs = "git restore";
      grsp = "git restore -p";
      grss = "git restore --staged";
      gs = "git status";
      gst = "git stash";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsts = "git stash show -p";
      gsw = if hasFzfGit then "git switch (__fzf_git_sh branches)" else "git switch";
      gwt = "git worktree";

      jc = "jj commit";
      jcm = "jj commit -m";
      jd = "jj diff";
      jdl = "jj diff -r @-"; # jj diff last
      js = "jj status";
    };

    shellAliases = {
      ls = "${lib.getExe pkgs.eza} --git --group-directories-first --time-style long-iso";
      nv = "nvim";
    };

    interactiveShellInit = ''
      bind \cj accept-autosuggestion execute
      bind \ck forward-word
      bind \cf "stty sane; nvim -c 'normal ' -c 'startinsert'"
      bind \cg "stty sane; nvim -c 'normal '"
    '';

    shellInit = ''
      fish_add_path --move ~/.local/bin

      update_theme # this is needed for the event handlers to work
    '';

    functions = {
      update_theme = {
        onEvent = [
          "fish_focus_in"
          "fish_prompt"
        ];
        body = ''
          if test "$(are-we-dark-yet)" = light
              set -f THEME tokyonight_day
          else
              set -f THEME tokyonight_storm
          end

          source "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/fish/$THEME.fish"
          return 0
        '';
      };
    };

    completions = {
      R = ''
        complete -c R -c r -c radian -f
        complete -c R -c r -c radian -o h -l help
        complete -c R -c r -c radian -l no-environ
        complete -c R -c r -c radian -l no-init-file
        complete -c R -c r -c radian -l no-save
        complete -c R -c r -c radian -l no-site-file
        complete -c R -c r -c radian -l vanilla
        complete -c R -c r -c radian -l version
        complete -c R -c r -c radian -o f -l file -r
        complete -c R -c r -c radian -o q -l quiet
      '';
    };
  };
}
