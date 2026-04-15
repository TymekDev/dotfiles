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
  xdg.configFile = lib.mkIf isDarwin {
    "jj/conf.d/work.toml".source = pkgs.writers.writeTOML "work.toml" {
      # NOTE: this cannot be "--when.repositories", because it won't apply correctly
      "--when" = {
        repositories = [ "~/work" ];
      };
      user.email = workEmail;
      signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB9tByXqdaKd0OpKWNYFgF0KHYANYJfCvbzSXdWaZh4A";
    };
  };

  programs.jujutsu = {
    enable = true;

    settings = {
      ui = {
        default-command = [
          "l"
          "-n"
          "10"
        ];
        diff-formatter = [
          "difft"
          "--syntax-highlight"
          "off"
          "--color"
          "always"
          "$left"
          "$right"
        ];
        pager = "less -FXR";
      };

      user = {
        name = "Tymoteusz Makowski";
        email = if isCodespace then workEmail else "tymek.makowski@gmail.com";
      };

      signing = lib.mkMerge [
        (lib.mkIf isCodespace {
          backend = "gpg";
        })
        (lib.mkIf (!isCodespace) {
          behavior = "own";
          backend = "ssh";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre";
          backends.ssh.program = opSshSign;
        })
      ];

      aliases = {
        l = [
          "log"
          "-r"
          "present(@) | ancestors(immutable_heads()..) | present(trunk()) | remote_bookmarks()"
        ];
      };
    };
  };
}
