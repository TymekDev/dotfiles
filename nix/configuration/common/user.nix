{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isLinux;
  home = if isLinux then "home" else throw "Unsupported OS";
in
{
  users.users.${config.dotfiles.username} = {
    home = "/${home}/${config.dotfiles.username}";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre"
    ];
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
