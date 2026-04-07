{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) hasGUI;
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.ghostty = {
    enable = hasGUI;
    package = lib.mkIf isDarwin null; # use homebrew

    settings = {
      font-family = "Berkeley Mono Trial";
      font-size = 16;
      theme = "light:TokyoNight Day,dark:TokyoNight Storm";

      # NOTE: I don't think uppercase letters work in the keybinds
      keybind =
        let
          leader = "ctrl+space";
          withLeader = key: mapping: "${leader}>${key}=${mapping}";
        in
        [
          (withLeader "c" "new_tab")

          # NOTE: this doesn't work as I'd want it to. See: https://github.com/ghostty-org/ghostty/discussions/11269
          (withLeader "o" "new_tab")
          "chain=text:opencode"
        ];
    };
  };
}
