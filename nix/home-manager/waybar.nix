{ ... }:
{
  programs.waybar = {
    enable = true;

    settings.main = {
      height = 30;

      modules-left = [
        "sway/workspaces"
      ];

      modules-center = [
        "mpris"
      ];

      modules-right = [
        "tray"
        "clock"
      ];

      clock = {
        "tooltip-format" = "<tt>{calendar}</tt>";
        "calendar" = {
          "format" = {
            "today" = "<span color='gold'><b>{}</b></span>";
          };
        };
      };

      mpris = {
        "format" = "{dynamic}";
        "format-paused" = "{status_icon} <i>{dynamic}</i>";
        "interval" = 1;
        "status-icons" = {
          "paused" = "⏸";
        };
      };

      tray = {
        "show-passive-items" = true;
        "spacing" = 8;
        "reverse-direction" = true;
      };
    };
  };
}
