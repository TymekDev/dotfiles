{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;

    difftastic.enable = true;

    aliases = {
      # [d]iff [c]ommit
      dc = "! f() { REF=\${1:-HEAD}; if [ $# -ge 1 ]; then shift 1; fi; git diff $REF~1 $REF $@; }; f";

      # [d]elete [m]erged
      dm = "! git branch --merged | grep -vE '(\\*|main|master)' | sed 's,^[+\\*] ,,' | xargs -n 1 git branch -d";

      # [f]ind [c]ode ([s]ingle)
      fc = "fl --all -S";
      fcs = "fl -S";

      # [f]ormat [l]og
      fl = "log --format='%C(yellow)%h  %C(blue)%cd  %C(auto)%s  %C(cyan)<%cn> %C(auto)%d' --date=short";

      # [g]raph ([s]ingle / [f]ull)
      g = "gf -15";
      gf = "fl --graph --all";
      gs = "fl --graph";

      # [l]ast [h]ash
      lh = "rev-parse @";

      pr = "! gh pr view --web";
    };

    extraConfig = {
      user = {
        name = "Tymoteusz Makowski";
        email = "tymek.makowski@gmail.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre";
      };

      gpg.format = "ssh";

      # FIXME: I think this uses a different verision than the one installed system-wide
      gpg."ssh".program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
      commit.gpgsign = true;

      branch.sort = "-committerdate";
      column.ui = "auto";
      core.editor = "nvim";
      credential.helper = "cache";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      merge.tool = "nvim";
      mergetool."nvim".cmd =
        ''nvim -d -c 'cd "$GIT_PREFIX"' -c 'wincmd J' "$MERGED" "$LOCAL" "$BASE" "$REMOTE"'';
      pull.rebase = false;
      push.autoSetupRemote = true;
      rebase.autoSquash = true;
      rebase.autoStash = true;
      rerere.enabled = true;
      worktree.guessRemote = true;
    };
  };
}
