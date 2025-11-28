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
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;

      settings = {
        ignore-empty-password = true;
        indicator-idle-visible = true;

        clock = true;
        screenshots = true;
        effect-pixelate = 25;
        effect-vignette = "0.5:0.5";
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

      timeouts =
        let
          minutes = seconds: 60 * seconds;
        in
        [
          {
            timeout = minutes 5;
            command = "swaylock -f";
          }
          {
            timeout = minutes 10;
            command = "swaymsg 'output * power off'";
            resumeCommand = "swaymsg 'output * power on'";
          }
          {
            timeout = minutes 30;
            command = "systemctl hibernate";
          }
        ];
    };
  };
}
