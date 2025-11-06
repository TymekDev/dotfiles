{ ... }:
{
  imports = [
    ./1password.nix
    ./greeter.nix
    ./i18n.nix
    ./openssh.nix
    ./sway.nix
  ];

  networking.firewall.allowedTCPPorts = [
    8000
    8080
  ];

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
}
