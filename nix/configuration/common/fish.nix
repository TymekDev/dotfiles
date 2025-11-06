{ config, pkgs, ... }:
{
  users.users.${config.dotfiles.username}.shell = pkgs.fish;
  programs.fish.enable = true;
}
