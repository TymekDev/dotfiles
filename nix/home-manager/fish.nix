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
      bind ctrl-j accept-autosuggestion execute
      bind ctrl-k forward-word
      bind ctrl-f "stty sane; nvim -c 'normal ' -c 'startinsert'"
      bind ctrl-g "stty sane; nvim -c 'normal '"

      # Mod+u/Mod+o in my UHK 60v2
      bind alt-left backward-bigword
      bind alt-right forward-bigword-end
    '';

    shellInit = ''
      fish_add_path --move ~/.local/bin

      if test -f ~/.local/state/nix/profile/etc/profile.d/nix.fish
          source ~/.local/state/nix/profile/etc/profile.d/nix.fish
      end

      if test -f /etc/fish/conf.d/codespaces.fish
          source /etc/fish/conf.d/codespaces.fish
      end
    '';

    functions = {
      copy.body = ''
        read -z input

        if test (echo "$input" | wc -l | tr -d '[:space:]') = 2
            echo -n "$input" | tr -d '\n' | fish_clipboard_copy
        else
            echo -n "$input" | fish_clipboard_copy
        end
      '';
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
