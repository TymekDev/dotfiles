{ ... }:
{
  imports = [
    ./homebrew.nix
    ./settings.nix
  ];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
}
