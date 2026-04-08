{ pkgs, ... }:
{
  imports = [
    ./homebrew.nix
    ./settings.nix
  ];

  environment.systemPackages = with pkgs; [ wezterm ];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
}
