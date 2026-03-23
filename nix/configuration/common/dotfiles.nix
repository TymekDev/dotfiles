{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
  inherit (pkgs.stdenv) isLinux isDarwin;
  home =
    if isLinux then
      "home"
    else if isDarwin then
      "Users"
    else
      throw "Unsupported OS";
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
          uid = mkOption {
            description = "The UID of the user (nix-darwin only)";
            default = null;
            type = types.nullOr types.int;
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

          isSway = mkOption {
            default = config.dotfiles.desktop == "sway";
            visible = false;
          };
          isCodespace = mkOption {
            default = builtins.getEnv "CODESPACES" == "true";
            visible = false;
          };
          home = mkOption {
            default = "/${home}/${config.dotfiles.username}";
            visible = false;
          };
        };
      };
    };
  };
}
