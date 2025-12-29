{ config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    extraPackages = with pkgs; [ mangohud ];
  };

  # TODO: does this do anything without explicitly enabling it?
  programs.gamemode = {
    enable = true;
    settings = {
      general.renice = 20;
      cpu.park_cores = true;
    };
  };

  users.users.${config.dotfiles.username}.extraGroups = [ "gamemode" ];
}
