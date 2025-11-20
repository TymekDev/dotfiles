{ ... }:
{
  # FIXME: lock before hibernation
  boot.initrd.systemd.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];
}
