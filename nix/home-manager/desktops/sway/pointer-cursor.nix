{ pkgs, ... }:
{
  # FEAT: make this switch between light and dark
  home.pointerCursor = {
    # name = "BreezeX-RosePine-Linux";
    name = "BreezeX-RosePineDawn-Linux";
    package = pkgs.rose-pine-cursor;
    dotIcons.enable = false;
    gtk.enable = true;
    sway.enable = true;
    size = 32;
  };
}
