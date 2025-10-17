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
        command = "${pkgs.sway}/bin/sway --config ${pkgs.writeText "greetd-sway-config" ''
          include /etc/sway/config.d/*
          output DP-3 disable
          exec "${pkgs.greetd.regreet}/bin/regreet; swaymsg exit"
        ''}";
        user = "greeter";
      };
    };
  };
}
