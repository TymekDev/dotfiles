{ config, ... }:
let
  username = config.dotfiles.username;
in
{
  imports = [
    ./config.nix
    ./home-manager.nix
    ./fish.nix
    ./fonts.nix
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Warsaw";
  environment.variables.TZ = "Europe/Warsaw";

  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
    ];
  };
}
