{ config, pkgs, lib, ... }:
let
  inherit (config.dotfiles) isSway;
in
{
  config = lib.mkIf isSway {
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
