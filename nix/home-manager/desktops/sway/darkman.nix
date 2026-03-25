{ config, lib, ... }:
{
  config = lib.mkIf config.dotfiles.isLinuxWithGUI {
    services.darkman = {
      enable = true;

      settings = {
        lat = 52.2;
        lng = 21.0;
      };
    };
  };
}
