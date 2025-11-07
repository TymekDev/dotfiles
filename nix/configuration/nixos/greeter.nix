{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.dotfiles.isSway {
    # TODO: customize the look
    programs.regreet = {
      enable = true;

      settings.background = {
        path = ../../../local/share/wallpaper.jpg;
        fit = "Cover";
      };
    };

    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${lib.getExe config.programs.sway.package} --config ${pkgs.writeText "greetd-sway-config" ''
            include /etc/sway/config.d/*
            output DP-3 disable
            exec "${lib.getExe config.programs.regreet.package}; swaymsg exit"
          ''}";
          user = "greeter";
        };
      };
    };
  };
}
