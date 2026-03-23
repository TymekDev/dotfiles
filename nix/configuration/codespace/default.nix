{ config, pkgs, ... }:
{
  home = {
    inherit (config.dotfiles) username;
    homeDirectory = config.dotfiles.home;
    packages = [ pkgs.nix-codespace-rebuild ];
  };

  nix.package = pkgs.nix;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
}
