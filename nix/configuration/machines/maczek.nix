{ ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  users.users.tymek.home = "/Users/tymek";

  system.stateVersion = 6;
}
