{ ... }:
{
  services.playerctld.enable = true;

  services.swaync.enable = true;

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

    style = ''
      window#waybar {
        background-color: rgba(43, 48, 59, 0.5);
        border-bottom: 2px solid rgba(100, 114, 125, 0.5);
        color: #ffffff;
      }

      .modules-right {
        padding-right: 10px;
      }

      #workspaces button {
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -2px transparent;
        border-radius: 0;
        padding: 0 5px;
        color: #ffffff;
      }

      #workspaces button.focused.visible {
        box-shadow: inset 0 -2px #ffffff;
        background-color: #64727D;
      }

      #workspaces button.visible { /* active workspace on an inactive monitor */
        box-shadow: inset 0 -2px #b3b3b3;
        background-color: #32393e;
      }

      #workspaces button.urgent {
        animation-name: blink-danger;
        animation-duration: 750ms;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
        box-shadow: inset 0 -2px #eb4d4b;
      }

      @keyframes blink-danger {
        to {
          background-color: #8a110f;
        }
      }

      #mode {
        background-color: #285577;
        font-style: italic;
        padding: 0 12px;
      }

      #custom-swaync {
        /* NOTE: those attributes somehow make the icon look centered */
        font-family: "JetBrainsMono Nerd Font Mono";
        font-size: 28px;
        margin-top: -2px;
        margin-bottom: -2px;
        margin-left: 2px;
      }
    '';
  };
}
