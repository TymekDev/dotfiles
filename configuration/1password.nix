{ config, lib, pkgs, ... } :
{
  nixpkgs.config.allowUnfreePredicate = pkg : builtins.elem (lib.getName pkg) [
    "1password"
    "1password-cli"
  ];

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "tymek" ];
    };
  };
}
