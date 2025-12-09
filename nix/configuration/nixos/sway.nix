{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.dotfiles.isSway {
    programs.sway.enable = true;

    xdg.portal = {
      enable = true;

      config.sway = {
        "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
      };
      extraPortals = with pkgs; [ darkman ];
      wlr.enable = true;
      xdgOpenUsePortal = true;
    };
  };
}
