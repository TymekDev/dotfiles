# FIXME: prevent the initial flash of default hyprland wallpaper
{ config, ... } :
let
  filename = "wallpaper.webp";
in
{
  xdg.dataFile."${filename}".source = ../../local/share/${filename};

  services.hyprpaper =
    let
      path = "~/${config.xdg.dataFile."${filename}".target}";
    in
    {
      enable = true;

      settings = {
        preload = [
          path
        ];

        wallpaper = [
          ",${path}"
        ];
      };
    };
}
