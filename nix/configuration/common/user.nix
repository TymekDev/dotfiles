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
  # Allows setting the user shell to fish
  programs.fish.enable = true;

  users.users.${config.dotfiles.username} = {
    home = "/${home}/${config.dotfiles.username}";
    shell = pkgs.fish;
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
