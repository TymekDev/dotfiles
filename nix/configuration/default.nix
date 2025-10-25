{ ... }:
{
  imports = [
    ./1password.nix
    ./fish.nix
    ./fonts.nix
    ./greeter.nix
    ./i18n.nix
    ./sway.nix
  ];

  networking.firewall.allowedTCPPorts = [
    8000
    8080
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  time.timeZone = "Europe/Warsaw";
  environment.variables.TZ = "Europe/Warsaw";

  users.users.tymek = {
    isNormalUser = true;
    home = "/home/tymek";
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
    ];
  };
}
