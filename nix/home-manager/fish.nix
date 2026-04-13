{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;

  hasFzfGit = config.programs.fzf.enable;

  themeName = "tokyonight";
  theme =
    let
      repo = fetchGit {
        url = "https://github.com/folke/tokyonight.nvim";
        rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
      };
    in
    lib.concatLines [
      "[light]"
      (builtins.readFile "${repo}/extras/fish_themes/tokyonight_day.theme")
      "[dark]"
      (builtins.readFile "${repo}/extras/fish_themes/tokyonight_storm.theme")
      ''
        [unknown]
        fish_color_normal --reset
        fish_color_autosuggestion brblack
        fish_color_cancel -r
        fish_color_command --reset
      ''
    ];
in
{
  xdg.configFile = {
    "fish/themes/${themeName}.theme".text = theme;
  }
  // lib.optionalAttrs hasFzfGit {
    "fish/conf.d/fzf-git.fish".source = "${pkgs.fzf-git-sh}/share/fzf-git-sh/fzf-git.fish";
  };

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
      grb = "git rebase";
      grbi = "git rebase --interactive";
      grbc = "git rebase --continue";
      grs = "git restore";
      grsp = "git restore -p";
      grss = "git restore --staged";
      gs = "git status";
      gst = "git stash";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsts = "git stash show -p";
      gsw = "git switch";
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
    }
    // lib.optionalAttrs isCodespace {
      # FIXME: tokyonight.nvim doesn't work with --headless
      # nvim = lib.getExe pkgs.nvim-persistent;
    };

    interactiveShellInit = ''
      bind ctrl-j accept-autosuggestion execute
      bind ctrl-k forward-word
      bind ctrl-f "stty sane; nvim -c 'normal '"
      bind ctrl-g "stty sane; nvim -c 'normal '"

      # Mod+u/Mod+o in my UHK 60v2
      bind alt-left backward-bigword
      bind alt-right forward-bigword-end

      fish_config theme choose ${themeName}
    '';

    shellInit = ''
      fish_add_path --move ~/.local/bin

      if test -d /usr/local/py-utils
          set -gx PIPX_HOME /usr/local/py-utils
          set -gx PIPX_BIN_DIR /usr/local/py-utils/bin
          fish_add_path --append $PIPX_BIN_DIR
      end

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
    };

    completions = {
      nix-codespace = ''
        complete -c nix-codespace -f
        complete -c nix-codespace -n __fish_use_subcommand -a rebuild -d "Rebuild Home Manager configuration"
        complete -c nix-codespace -n __fish_use_subcommand -a version -d "Print the dotfiles commit of the current configuration"
        complete -c nix-codespace -n "__fish_seen_subcommand_from rebuild version" -f
        complete -c nix-codespace -n "__fish_seen_subcommand_from rebuild" -a "(git ls-remote -b https://code.tymek.dev/TymekDev/dotfiles 2>/dev/null | grep -o '[^/]\+\$')" -d "Branch ref"
      '';
      nix-cs = ''
        complete -c nix-cs --wraps nix-codespace
      '';
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
