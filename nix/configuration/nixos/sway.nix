{ config, ... }:
{
  programs.sway.enable = config.dotfiles.isSway;
}
