{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.wayland.windowManager.sway.config;
in
{
  services.swayosd.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
      modifier = "Mod4";

      input."*".xkb_layout = "pl";

      terminal = lib.getExe pkgs.wezterm;

      startup = [
        {
          command = "1password --silent";
          always = true;
        }
        {
          command = "swaymsg focus output DP-2";
        }
        {
          command = "blueman-applet";
          always = true;
        }
      ];

      bars = [
        { command = "${pkgs.waybar}/bin/waybar"; }
      ];

      keybindings =
        let
          grimshot = args: "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot ${args}";
          swayosd = args: "exec ${config.services.swayosd.package}/bin/swayosd-client ${args}";
          mod = cfg.modifier;
        in
        {
          "${mod}+Return" = "exec ${cfg.terminal}";
          "${mod}+D" = "exec ${cfg.menu}";

          "Print" = grimshot "copy area";
          "Shift+Print" = grimshot "copy anything";

          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+r" = "reload";
          "${mod}+Shift+e" = ''
            exec swaynag \
              -t  warning \
              -m 'Sup?' \
              -B 'Poweroff' 'systemctl poweroff' \
              -B 'Exit sway' 'swaymsg exit' \
              -B 'Reboot' 'systemctl reboot' \
              -B 'Sleep' 'systemctl suspend'
          '';

          "${mod}+Space" = "focus mode_toggle";
          "${mod}+Shift+Space" = "floating toggle";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+r" = "mode resize";
          "${mod}+a" = "focus parent";
          "${mod}+z" = "focus child";

          "${mod}+q" = "split toggle";
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";

          "${mod}+e" = "layout toggle split";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";

          "--locked XF86AudioLowerVolume" = swayosd "--output-volume -5";
          "--locked XF86AudioRaiseVolume" = swayosd "--output-volume +5";
          "--locked XF86AudioPrev" = swayosd "--playerctl previous";
          "--locked XF86AudioNext" = swayosd "--playerctl next";
          "--locked XF86AudioPlay" = swayosd "--playerctl play-pause";
        };

      output = {
        DP-2 = {
          background = "${../../local/share/wallpaper.jpg} fill";
          position = "0 0";
        };
        DP-3 = {
          background = "${../../local/share/wallpaper.jpg} fill";
          position = "2560 0";
          transform = "90";
        };
      };

      workspaceOutputAssign =
        (map (ws: {
          workspace = toString ws;
          output = "DP-2";
        }) (lib.range 1 4))
        ++ [
          {
            workspace = "5";
            output = "DP-3";
          }
        ];
    };
  };
}
