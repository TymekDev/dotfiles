{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options = {
    dotfiles = mkOption {
      type = types.submodule {
        options = {
          username = mkOption {
            description = "The username of the user";
            type = types.str;
          };
        };
      };
    };
  };
}
