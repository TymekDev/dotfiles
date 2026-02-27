{ config, pkgs, ... }:
{
  environment.variables.SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";

  programs = {
    _1password = {
      enable = true;
      package = pkgs._1password-cli;
    };

    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ config.dotfiles.username ];
      package = pkgs._1password-gui;
    };
  };
}
