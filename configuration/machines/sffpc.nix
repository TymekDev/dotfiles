{ pkgs, ... } :
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  environment.variables = {
    EDITOR = "nvim";
    SSH_AUTH_SOCK = "~/.1password/agent.sock";
  };

  networking.hostName = "sffpc";

  users.users.tymek = {
    isNormalUser = true;
    home = "/home/tymek";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  time.timeZone = "Europe/Warsaw";

  system.stateVersion = "24.11";
}
