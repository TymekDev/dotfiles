{ ... }:
{
  imports = [
    ./1password.nix
    ./greeter.nix
    ./i18n.nix
    ./openssh.nix
    ./sway.nix
  ];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  services.playerctld.enable = true;
}
