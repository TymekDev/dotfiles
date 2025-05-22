{ pkgs, lib, ... } :
{
  programs.git = {
    enable = true;

    extraConfig = {
      user = {
        name = "Tymoteusz Makowski";
        email = "tymek.makowski@gmail.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre";
      };

      gpg.format = "ssh";
      gpg."ssh".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      commit.gpgsign = true;
    };
  };
}
