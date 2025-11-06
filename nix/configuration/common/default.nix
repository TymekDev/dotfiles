{ ... }:
{
  imports = [
    ./home-manager.nix
    ./fish.nix
    ./fonts.nix
  ];

  nixpkgs.config.allowUnfree = true;

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
