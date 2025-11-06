{ ... }:
{
  imports = [
    ./config.nix
    ./home-manager.nix
    ./fish.nix
    ./fonts.nix
    ./user.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
