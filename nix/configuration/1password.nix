{ pkgs-unstable, ... }:
{
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
