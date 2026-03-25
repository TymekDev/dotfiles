{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.dotfiles.isLinuxWithGUI {
    home.pointerCursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      dotIcons.enable = false;
      gtk.enable = true;
      sway.enable = true;
      size = 32;
    };
  };
}
