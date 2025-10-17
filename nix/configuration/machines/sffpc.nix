{ ... }:
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.hostName = "sffpc";

  services.blueman.enable = true;

  system.stateVersion = "24.11";
}
