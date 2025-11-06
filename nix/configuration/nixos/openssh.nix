{ config, ... }:
{
  services.openssh = {
    enable = true;

    ports = [
      5858
    ];

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ config.dotfiles.username ];
    };
  };
}
