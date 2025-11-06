{ pkgs, ... }:
{
  users.users.tymek.shell = pkgs.fish;
  programs.fish.enable = true;
}
