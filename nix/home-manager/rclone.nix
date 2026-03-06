{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  xdg.configFile."rclone/rclone.conf".source = lib.mkIf isDarwin ../../config/rclone/rclone.conf;

  programs.rclone = {
    enable = true;

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
