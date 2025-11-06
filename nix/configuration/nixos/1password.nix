{ pkgs-unstable, ... }:
{
  environment.variables.SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";

  programs = {
    _1password = {
      enable = true;
      package = pkgs-unstable._1password-cli;
    };

    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "tymek" ];
      package = pkgs-unstable._1password-gui;
    };
  };
}
