{ config, ... }:
let
  inherit (config.dotfiles) isCodespace;

  socketHomeDir = ".ssh/sockets";

  # NOTE: I'd rather have the config stored here, but importing from ssh to rclone doesn't seem to work.
  fromRclone =
    remote: with config.programs.rclone.remotes."${remote}".config; {
      inherit port user;
      hostname = host;
    };
in
{
  # See https://github.com/nix-community/home-manager/issues/2104
  home.file."${socketHomeDir}/.keep".source = builtins.toFile "keep" "";

  programs.ssh = {
    enable = !isCodespace;
    enableDefaultConfig = false;

    includes = [ "codespaces" ];

    matchBlocks = {
      helix = fromRclone "helix";
      hetzner = fromRclone "hetzner";

      "appsilon.github.com" = {
        hostname = "github.com";
        identityFile = "${config.dotfiles.home}/.ssh/id_ed25519_github";
        identitiesOnly = true;
      };

      "*" = {
        controlPath = "~/${socketHomeDir}/%r@%h:%p";
        controlPersist = "600";
        identityAgent = "SSH_AUTH_SOCK";
      };
    };
  };
}
