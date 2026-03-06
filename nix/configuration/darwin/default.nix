{ ... }:
{
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
}
