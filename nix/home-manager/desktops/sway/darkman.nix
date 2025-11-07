{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isSway;
in
{
  config = lib.mkIf isSway {
    services.darkman = {
      enable = true;

      settings = {
        lat = 52.2;
        lng = 21.0;
      };
    };

    xdg.portal = {
      enable = true;

      config.sway = {
        "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
      };

      extraPortals = [ pkgs.darkman ];
    };
  };
}
