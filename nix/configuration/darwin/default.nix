{ ... }:
{
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  security.pam.services.sudo_local.touchIdAuth = true;
}
