{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.ghostty = {
    enable = true;
    package = lib.mkIf isDarwin null; # use homebrew

    settings = {
      font-size = 19;
      adjust-cell-width = "-10%";
      theme = "TokyoNight Day";
      background = "#f1f2f7"; # NOTE: this doesn't support the light/dark syntax.

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
