{ config, lib, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks."*" = lib.hm.dag.entryAfter (builtins.attrNames config.programs.ssh.matchBlocks) {
      identityAgent = "~/.1password/agent.sock";
    };

    matchBlocks = {
      helix = {
        hostname = "helix.lambda.town";
        port = 2116;
        user = "tymek";
      };

      hetzner = {
        hostname = "u375346.your-storagebox.de";
        port = 23;
        user = "u375346";
      };
    };
  };
}
