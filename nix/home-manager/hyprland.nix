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

      monitor = [
        # name, resolution, position, scale, ...
        "DP-3, preferred, auto, 1, transform, 3"
      ];

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

      animations.animation = [
        "global, 0"
      ];
    };
  };
}
