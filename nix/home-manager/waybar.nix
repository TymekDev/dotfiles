{ pkgs, lib, ... }:
let
  # Credit to Winston: https://code.winston.sh/winston/flake/src/commit/ea16b8325243824523fc72ef94f4f9d8d5ddac9b/home/apps/wm/waybar.nix#L151-L167
  buildStyle =
    appearance:
    pkgs.runCommandNoCC "hm_waybarstyle${appearance}.css" {
      nativeBuildInputs = [ pkgs.dart-sass ];
      style = ''
        @use "${./scss}/waybar" with (
          $dark: ${lib.boolToString (appearance == "dark")}
        );
      '';
      passAsFile = [ "style" ];
    } "sass --no-source-map $stylePath $out";
in

{
  services.playerctld.enable = true;

  services.swaync.enable = true;

  xdg.configFile = {
    "waybar/style-dark.css".source = buildStyle "dark";
    "waybar/style-light.css".source = buildStyle "light";
  };

  programs.waybar = {
    enable = true;

    settings.main = {
      height = 30;
      spacing = 12;

      modules-left = [
        "sway/workspaces"
        "sway/mode"
      ];

      modules-center = [
        "mpris"
      ];

      modules-right = [
        "pulseaudio"
        "tray"
        "clock"
        "custom/swaync"
        # TODO: custom/quit
      ];

      clock = {
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          format = {
            today = "<span color='gold'><b>{}</b></span>";
          };
        };
      };

      # TODO: update this config
      mpris = {
        format = "{dynamic}";
        format-paused = "{status_icon} <i>{dynamic}</i>";
        interval = 1;
        status-icons = {
          paused = "⏸";
        };
      };

      pulseaudio = {
        format = "<span>{icon}</span>   {volume}%";
        format-icons = {
          default = "";
          default-muted = "";
        };
        on-click = "pactl set-sink-mute 0 toggle";
      };

      "sway/workspaces" = {
        format = "";
        persistent-workspaces = {
          "1" = [ "DP-2" ];
          "2" = [ "DP-2" ];
          "3" = [ "DP-2" ];
          "4" = [ "DP-2" ];
        };
      };

      # TODO: revisit spacing with styling
      tray = {
        show-passive-items = true;
        spacing = 4;
        reverse-direction = true;
      };

      "custom/swaync" = {
        format = "{icon}";
        format-icons = {
          notification = "󱅫";
          none = "󰂜";
          dnd-notification = "󰂠";
          dnd-none = "󰪓";
          inhibited-notification = "󰂛";
          inhibited-none = "󰪑";
          dnd-inhibited-notification = "󰂛";
          dnd-inhibited-none = "󰪑";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
    };
  };
}
