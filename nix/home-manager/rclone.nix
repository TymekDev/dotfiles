{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
  inherit (pkgs.stdenv) isDarwin;

  remotes =
    let
      sftpConfig =
        {
          host,
          user,
          port,
        }:
        {
          inherit host user port;
          type = "sftp";
          shell_type = "unix";
          md5sum_command = "md5sum";
          sha1sum_command = "sha1sum";
        };
    in
    {
      helix.config = sftpConfig {
        host = "helix.lambda.town";
        user = "tymek";
        port = 2116;
      };

      hetzner.config = sftpConfig {
        host = "u375346.your-storagebox.de";
        user = "u375346";
        port = 23;
      };
    };
in
{
  # NOTE: this is needed for nix-darwin as the rclone home-manager module uses systemd to update the config file.
  xdg.configFile."rclone/rclone.conf" = lib.mkIf isDarwin {
    source = (pkgs.formats.ini { }).generate "rclone.conf" (
      builtins.mapAttrs (name: value: value.config) remotes
    );
  };

  programs.rclone = {
    enable = !isCodespace;

    inherit remotes;
  };
}
