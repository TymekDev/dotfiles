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

  time.timeZone = "Europe/Warsaw";
  environment.variables.TZ = "Europe/Warsaw";
}
