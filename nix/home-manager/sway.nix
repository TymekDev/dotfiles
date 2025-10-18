{
  config,
  pkgs,
  lib,
  ...
}:
{
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
          command = "blueman-tray";
          always = true;
        }
      ];

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
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
