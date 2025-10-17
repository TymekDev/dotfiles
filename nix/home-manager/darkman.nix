{ pkgs, ... }:
{
  services.darkman = {
    enable = true;

    settings = {
      lat = 52.2;
      lng = 21.0;
    };
  };

  xdg.portal = {
    enable = true;

    config = {
      common.default = [ "gtk" ];

      sway = {
        "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
      };
    };

    extraPortals = [ pkgs.darkman ];
  };
}
