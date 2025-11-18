{
  config,
  pkgs-unstable,
  lib,
  ...
}:
let
  inherit (config.dotfiles) hasGhostty;
in
{
  config = lib.mkIf hasGhostty {
    programs.ghostty = {
      enable = true;
      package = pkgs-unstable.ghostty;

      enableFishIntegration = true;
      settings = {
        theme = "light:TokyoNight Day,dark:TokyoNight Storm";
        font-size = 14;
        shell-integration-features = "no-cursor";
        cursor-style-blink = false;
      };
    };
  };
}
