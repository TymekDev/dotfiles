{ ... } :
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
    extraGroups = [ "wheel" "networkmanager" ];
  };

  time.timeZone = "Europe/Warsaw";

  system.stateVersion = "24.11";
}
