{ pkgs, ... }:
{
  # TODO: customize the look
  programs.regreet = {
    enable = true;

    settings.background = {
      path = ../../local/share/wallpaper.jpg;
      fit = "Cover";
    };
  };

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland --config ${pkgs.writeText "greetd-hyprland-config" ''
          monitor = DP-2, preferred, auto, 1
          monitor = , disable

          misc {
            disable_hyprland_logo = true
            disable_splash_rendering = true
            disable_hyprland_qtutils_check = true
          }

          animations {
            animation = global, 0
          }

          exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
        ''}";
        user = "greeter";
      };
    };
  };
}
