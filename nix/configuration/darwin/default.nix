{ pkgs, ... }:
{
  imports = [
    ./homebrew.nix
    ./keyboard.nix
    ./settings.nix
  ];

  # Installed via nix-darwin, so it can be found in /Applications/Nix Apps/
  environment.systemPackages = with pkgs; [ wezterm ];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
}
