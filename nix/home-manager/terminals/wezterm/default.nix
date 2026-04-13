{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace isLinuxWithGUI;
  inherit (pkgs.stdenv) isDarwin isLinux;

  mkSymlink =
    path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.home}/personal/dotfiles/${path}";
in
{
  # NOTE: I cannot use ./wezterm.lua and similar, because those files are included as source in
  # /nix/store/ and the out-of-store symlink ends up being an in-store symlink.
  xdg.configFile = {
    "wezterm/codespaces.lua".source = mkSymlink "config/wezterm/codespaces.lua";
    "wezterm/sessionizer.lua".source = mkSymlink "config/wezterm/sessionizer.lua";
    "wezterm/tab_bar.lua".source = mkSymlink "config/wezterm/tab_bar.lua";
    "wezterm/theme.lua".source = mkSymlink "config/wezterm/theme.lua";
  }
  // lib.optionalAttrs isDarwin {
    "wezterm/wezterm.lua".source = mkSymlink "config/wezterm/wezterm.lua";
  }
  // lib.optionalAttrs isLinux {
    "wezterm/wezterm.lua".source = mkSymlink "nix/home-manager/terminals/wezterm/wezterm.lua";
  };

  programs.wezterm.enable = isLinuxWithGUI;

  home.sessionSearchVariables = lib.mkIf isCodespace {
    TERMINFO_DIRS = [ "${pkgs.wezterm.terminfo}/share/terminfo" ];
  };
}
