{ pkgs, lib, ... } :
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      "$terminal" = "${lib.getExe pkgs.wezterm}";
      "$mainMod" = "SUPER";

      decoration.rounding = 10;
      misc.disable_hyprland_logo = true;

      input = {
        kb_layout = "pl";
        accel_profile = "flat";
      };

      exec-once = [
        "uwsm app -- 1password --silent"
        "${lib.getExe pkgs.waybar}"
      ];

      general = {
        allow_tearing = false;
        layout = "master";

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg"; # TODO: update me
      };

      bind = [
        "$mainMod, Q, killactive,"
        "$mainMod, T, exec, $terminal"
        "$mainMod, D, exec, eval \"$(tofi-drun)\""
        "$mainMod SHIFT, J, togglesplit, # dwindle"
        "$mainMod, space, fullscreenstate, 2"

        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        "SUPER CTRL, h, movewindow, l"
        "SUPER CTRL, j, movewindow, d"
        "SUPER CTRL, k, movewindow, u"
        "SUPER CTRL, l, movewindow, r"

        "CTRL, 1, workspace, 1"
        "CTRL, 2, workspace, 2"
        "CTRL, 3, workspace, 3"
        "CTRL, 4, workspace, 4"
        "CTRL, 5, workspace, 5"

        "CTRL SUPER, 1, movetoworkspace, 1"
        "CTRL SUPER, 2, movetoworkspace, 2"
        "CTRL SUPER, 3, movetoworkspace, 3"
        "CTRL SUPER, 4, movetoworkspace, 4"
        "CTRL SUPER, 5, movetoworkspace, 5"
      ];

      windowrulev2 = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      animations = {
        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
    };
  };
}
