{ pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.hostName = "sffpc";

  nixpkgs.config.allowUnfree = true;

  users.users.tymek = {
    isNormalUser = true;
    home = "/home/tymek";
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
    ];
  };

  time.timeZone = "Europe/Warsaw";

  services.blueman.enable = true;

  system.stateVersion = "24.11";
}
