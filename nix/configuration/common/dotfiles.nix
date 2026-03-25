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
          isCodespace = mkOption {
            description = "Whether we're running in a GitHub Codespace Linux environment";
            type = types.bool;
            default = false;
          };

          hasGUI = mkOption {
            default = isDarwin || (isLinux && !config.dotfiles.isCodespace);
            visible = false;
          };
          isLinuxWithGUI = mkOption {
            default = isLinux && config.dotfiles.hasGUI;
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
