{ config, lib, ... }:
let
  inherit (config.dotfiles) isSway;
in
{
  config = lib.mkIf isSway {
    programs.swaylock = {
      enable = true;

      settings = {
        image = ../../../../local/share/wallpaper.jpg;
        ignore-empty-password = true;
        indicator-idle-visible = true;
      };
    };

    services.swayidle = {
      enable = true;

      events = [
        {
          event = "before-sleep";
          command = "swaylock -f";
        }
      ];

      timeouts = [
        {
          timeout = 300;
          command = "swaylock -f";
        }
        {
          timeout = 600;
          command = "swaymsg 'output * power off'";
          resumeCommand = "swaymsg 'output * power on'";
        }
      ];
    };
  };
}
