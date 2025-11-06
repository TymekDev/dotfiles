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

  users.users.${config.dotfiles.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkf84+zcnJNPvvNC2uskzM860ewSX5tLo57A7jA8Yre"
  ];
}
