{ ... }:
{
  imports = [
    ./disko.nix
    ./hardware.nix
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    keyboard.uhk.enable = true;

    opentabletdriver.enable = true;
  };

  networking.hostName = "sffpc";

  services.blueman.enable = true;

  time.timeZone = "Europe/Warsaw";

  system.stateVersion = "24.11";
}
