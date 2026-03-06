{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  # Allows setting the user shell to fish
  programs.fish.enable = true;

  users = {
    users.${config.dotfiles.username} = {
      inherit (config.dotfiles) home;
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre"
      ];
    }
    // lib.optionalAttrs isDarwin {
      uid = config.dotfiles.uid;
    }
    // lib.optionalAttrs isLinux {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
      ];
    };
  }
  // lib.optionalAttrs isDarwin {
    knownUsers = [ config.dotfiles.username ];
  };
}
