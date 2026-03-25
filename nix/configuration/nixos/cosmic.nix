{ config, ... }:
{
  services.desktopManager.cosmic.enable = config.dotfiles.isLinuxWithGUI;
}
