{ config, pkgs-unstable, ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hmbak";
    extraSpecialArgs = { inherit pkgs-unstable; };
    users.${config.dotfiles.username}.imports = [ ../../home-manager ];
  };
}
