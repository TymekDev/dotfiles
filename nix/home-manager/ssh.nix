{ config, lib, ... }:
let
  # NOTE: I'd rather have the config stored here, but importing from ssh to rclone doesn't seem to work.
  fromRclone =
    remote: with config.programs.rclone.remotes."${remote}".config; {
      inherit port user;
      hostname = host;
    };
in
{
  programs.ssh = {
    enable = true;

    matchBlocks."*" = lib.hm.dag.entryAfter (builtins.attrNames config.programs.ssh.matchBlocks) {
      identityAgent = "~/.1password/agent.sock";
    };

    matchBlocks = {
      helix = fromRclone "helix";
      hetzner = fromRclone "hetzner";
    };
  };
}
