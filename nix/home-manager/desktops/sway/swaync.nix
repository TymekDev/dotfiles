{ config, lib, ... }:
{
  config = lib.mkIf config.dotfiles.isLinuxWithGUI {
    services.swaync.enable = true;
  };
}
