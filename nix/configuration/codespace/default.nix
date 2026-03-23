{ config, pkgs, ... }:
let
  username = config.dotfiles.username;
in
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  nix.package = pkgs.nix;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
}
