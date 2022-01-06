{ config, pkgs, ... }:

{
  home = {
    username = "tmakowski";
    homeDirectory = "/home/tmakowski";
    stateVersion = "22.05";
  };
  programs.home-manager.enable = true;
}
