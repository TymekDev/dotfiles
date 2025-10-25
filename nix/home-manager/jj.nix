{ pkgs, lib, ... }:
{
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
      };

      user = {
        name = "Tymoteusz Makowski";
        email = "tymek.makowski@gmail.com";
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre";

        backends.ssh.program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
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
