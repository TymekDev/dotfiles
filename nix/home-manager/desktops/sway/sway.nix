# FIXME: sometimes (after power off?) the dmenu begins to start at the secondary monitor (which is now listed first by swaymsg -t get_outputs)
{
  config,
  pkgs-unstable,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isSway;

  cfg = config.wayland.windowManager.sway.config;
  mod = "Mod4";
  modMove = "${mod}+Shift";
in
{
  config = lib.mkIf isSway {
    wayland.windowManager.sway = {
      enable = true;
      package = null;

      config = {
        modifier = mod;

        input = {
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0";
          };
          "type:keyboard" = {
            xkb_layout = "pl";
          };
        };

        terminal = lib.getExe config.programs.wezterm.package;

        startup = [
          { command = "1password --silent"; }
          { command = "swaymsg focus output DP-2"; }
          { command = "blueman-applet"; }
        ];

        window.commands =
          let
            floating = criteria: {
              command = "floating enable";
              inherit criteria;
            };
            sticky = criteria: {
              command = "sticky enable";
              inherit criteria;
            };
          in
          [
            (sticky { app_id = "1password"; })
            (floating { app_id = "1password"; })
            (floating { class = "net-runelite-client-RuneLite"; })
            (floating { class = "net-runelite-launcher-Launcher"; })
            (floating { class = "BoltLauncher"; })
          ];

        keybindings =
          let
            grimshot =
              args:
              "exec ${lib.getExe pkgs-unstable.sway-contrib.grimshot} ${args} && ${swayosd "--custom-message 'yoink' --custom-icon 'edit-copy'"}";
            swayosd = args: "exec swayosd-client ${args}";
          in
          {
            "${mod}+Return" = "exec ${cfg.terminal}";
            "${mod}+Space" = "exec ${cfg.menu}";

            "Print" = grimshot "copy area";
            "Shift+Print" = grimshot "copy anything";

            "${mod}+Shift+m" = "exec darkman toggle";
            "${mod}+Shift+Space" = "exec 1password --quick-access";

            "${mod}+Ctrl+q" = "exec swaylock -f";
            "${mod}+Shift+q" = "kill";
            "${mod}+Shift+r" = "reload";
            "${mod}+Shift+e" = ''
              exec swaynag \
                -t  warning \
                -m 'Sup?' \
                -B 'Poweroff' 'systemctl poweroff' \
                -B 'Hibernate' 'systemctl hibernate' \
                -B 'Exit sway' 'swaymsg exit' \
                -B 'Reboot' 'systemctl reboot' \
                -B 'Sleep' 'systemctl suspend'
            '';

            "${mod}+d" = "focus mode_toggle";
            "${mod}+Shift+d" = "floating toggle";

            "${mod}+f" = "fullscreen toggle";
            "${mod}+r" = "mode resize";
            "${mod}+a" = "focus parent";
            "${mod}+z" = "focus child";

            "${mod}+q" = "split toggle";
            "${mod}+b" = "splith";
            "${mod}+v" = "splitv";

            "${mod}+e" = "layout toggle split";
            "${mod}+s" = "layout stacking";
            "${mod}+t" = "layout tabbed";

            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";

            "${modMove}+h" = "move left";
            "${modMove}+j" = "move down";
            "${modMove}+k" = "move up";
            "${modMove}+l" = "move right";

            "${mod}+1" = "workspace number 1";
            "${mod}+2" = "workspace number 2";
            "${mod}+3" = "workspace number 3";
            "${mod}+4" = "workspace number 4";
            "${mod}+5" = "workspace number 5";

            "${modMove}+1" = "move container to workspace number 1";
            "${modMove}+2" = "move container to workspace number 2";
            "${modMove}+3" = "move container to workspace number 3";
            "${modMove}+4" = "move container to workspace number 4";
            "${modMove}+5" = "move container to workspace number 5";

            "--locked XF86AudioLowerVolume" = swayosd "--output-volume -5";
            "--locked XF86AudioRaiseVolume" = swayosd "--output-volume +5";
            "--locked XF86AudioPrev" = swayosd "--playerctl previous";
            "--locked XF86AudioNext" = swayosd "--playerctl next";
            "--locked XF86AudioPlay" = swayosd "--playerctl play-pause";
          };

        modes = {
          resize = {
            Escape = "mode default";
            "${mod}+R" = "mode default";
            h = "resize shrink width 10 px or 10 ppt";
            j = "resize shrink height 10 px or 10 ppt";
            k = "resize grow height 10 px or 10 ppt";
            l = "resize grow width 10 px or 10 ppt";
          };
        };

        output = {
          DP-2 = {
            background = "${../../../../local/share/wallpaper.jpg} fill";
            position = "0 0";
          };
          DP-3 = {
            background = "${../../../../local/share/wallpaper.jpg} fill";
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
  };
}
