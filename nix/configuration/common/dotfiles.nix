{ config, lib, ... }:
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
          desktop = mkOption {
            description = "The desktop environment to use (linux only)";
            default = null;
            type = types.nullOr (
              types.enum [
                "sway"
              ]
            );
          };
          gaming = mkOption {
            description = "Gaming-related stuff to include";
            default = [ ];
            type = types.listOf (types.enum [ "osrs" ]);
          };

          isSway = mkOption {
            default = config.dotfiles.desktop == "sway";
            visible = false;
          };
          hasOSRS = mkOption {
            default = builtins.elem "osrs" config.dotfiles.gaming;
            visible = false;
          };
        };
      };
    };
  };
}
