{ ... }:
{
  imports = [
    ./1password.nix
    ./environment.nix
    ./fish.nix
    ./fonts.nix
    ./greeter.nix
    ./hyprland.nix
    ./i18n.nix
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
