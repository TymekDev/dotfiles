{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
  inherit (pkgs.stdenv) isDarwin;

  workEmail = "tymoteusz.makowski@appsilon.com";
  opSshSign =
    if isDarwin then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" else "op-ssh-sign";
in
{
  programs.difftastic = {
    enable = true;

    git.enable = true;
  };

  programs.git = {
    enable = true;
    package = lib.mkIf isCodespace null;

    includes = [
      (lib.mkIf isDarwin {
        condition = "gitdir:~/work/";
        contents = {
          user = {
            email = workEmail;
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB9tByXqdaKd0OpKWNYFgF0KHYANYJfCvbzSXdWaZh4A";
          };
        };
      })
    ];

    signing = {
      format = if isCodespace then null else "ssh"; # NOTE: the explicit null is required
      signByDefault = true;
      signer = lib.mkIf (!isCodespace) opSshSign;
    };

    settings.alias = {
      # [d]iff [c]ommit
      dc = "! f() { REF=\${1:-HEAD}; if [ $# -ge 1 ]; then shift 1; fi; git diff $REF~1 $REF $@; }; f";

      # [d]elete [m]erged
      dm = "! git branch --merged | grep -vE '(\\*|main|master)' | sed 's,^[+\\*] ,,' | xargs -n 1 git branch -d";

      # [f]ind [c]ode ([s]ingle)
      fc = "fl --all -S";
      fcs = "fl -S";

      # [f]ormat [l]og
      fl = "log --format='%C(yellow)%h  %C(blue)%cd %C(dim)%ad%C(reset)  %C(auto)%s  %C(cyan)<%cn> %C(auto)%d' --date=short";

      # [g]raph ([s]ingle / [f]ull)
      g = "gf -15";
      gf = "fl --graph --all";
      gs = "fl --graph";

      # [l]ast [h]ash
      lh = "rev-parse @";

      pr = "! gh pr view --web";
    };

    settings = {
      user = lib.mkIf (!isCodespace) {
        name = "Tymoteusz Makowski";
        email = "tymek.makowski@gmail.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre";
      };

      branch.sort = "-committerdate";
      column.ui = "auto";
      core.editor = "nvim";
      credential.helper = "cache";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      merge.tool = "nvim";
      mergetool."nvim".cmd =
        ''nvim -d -c 'cd "$GIT_PREFIX"' -c 'wincmd J' "$MERGED" "$LOCAL" "$BASE" "$REMOTE"'';
      push.autoSetupRemote = true;
      rebase.autoSquash = true;
      rebase.autoStash = true;
      rerere.enabled = true;
      worktree.guessRemote = true;
    };
  };
}
