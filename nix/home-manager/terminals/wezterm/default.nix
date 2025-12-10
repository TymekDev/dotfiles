{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isLinux;

  home = if isLinux then "home" else throw "Unsupported OS";
  mkSymlink =
    path:
    config.lib.file.mkOutOfStoreSymlink "/${home}/${config.dotfiles.username}/personal/dotfiles/${path}";
in
{
  # NOTE: I cannot use ./wezterm.lua and similar, because those files are included as source in
  # /nix/store/ and the out-of-store symlink ends up being an in-store symlink.
  xdg.configFile = {
    "wezterm/wezterm.lua".source = mkSymlink "nix/home-manager/terminals/wezterm/wezterm.lua";
    "wezterm/sessionizer.lua".source = mkSymlink "config/wezterm/sessionizer.lua";
    "wezterm/tab_bar.lua".source = mkSymlink "config/wezterm/tab_bar.lua";
    "wezterm/theme.lua".source = mkSymlink "config/wezterm/theme.lua";
  };

  programs.wezterm = {
    enable = true;
    package = pkgs-unstable.wezterm;
  };
}
