{ config, lib, ... }:
{
  config = lib.mkIf config.dotfiles.isLinuxWithGUI {
    services.swayosd.enable = true;
  };
}
