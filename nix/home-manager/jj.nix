# TODO: support nix-darwin
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
  inherit (pkgs.stdenv) isDarwin isLinux;

  opSshSign =
    if isDarwin then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" else "op-ssh-sign";
in
{
  programs.jujutsu = lib.mkIf (isLinux && !isCodespace) {
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
        email = "tymek.makowski@gmail.com";
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre";
        backends.ssh.program = opSshSign;
      };

      aliases = {
        l = [
          "log"
          "-r"
          "present(@) | ancestors(immutable_heads()..) | present(trunk())"
        ];
      };
    };
  };
}
