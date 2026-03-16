{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;

  mkSymlink =
    path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.home}/personal/dotfiles/${path}";

  emmyLuaSpoon = pkgs.fetchzip {
    url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/EmmyLua.spoon.zip";
    hash = "sha256-frXlZzV7soSDGpepiVT+EKe4Td5HtKp7/BL2uRBroPQ=";
  };
in
{
  config = lib.mkIf isDarwin {
    xdg.configFile = {
      "hammerspoon/init.lua".source = mkSymlink "config/hammerspoon/init.lua";
      "hammerspoon/Spoons/EmmyLua.spoon/init.lua".source = "${emmyLuaSpoon}/init.lua";
      "hammerspoon/Spoons/EmmyLua.spoon/docs.json".source = "${emmyLuaSpoon}/docs.json";
    };
  };
}
