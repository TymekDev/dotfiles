{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
  inherit (pkgs.stdenv) isDarwin;
in
{
  xdg.configFile."rclone/rclone.conf" = lib.mkIf isDarwin {
    source = ../../config/rclone/rclone.conf;
  };

  programs.rclone = {
    enable = !isCodespace;

    remotes = {
      helix.config = {
        type = "sftp";
        host = "helix.lambda.town";
        user = "tymek";
        port = 2116;
      };

      hetzner.config = {
        type = "sftp";
        host = "u375346.your-storagebox.de";
        user = "u375346";
        port = 23;
      };
    };
  };
}
