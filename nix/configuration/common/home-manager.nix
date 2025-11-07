{ config, pkgs-unstable, ... }:
let
  osDotfiles = config.dotfiles;
in
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hmbak";
    extraSpecialArgs = { inherit pkgs-unstable; };
    users.${config.dotfiles.username}.imports = [
      ../../home-manager

      (
        { config, lib, ... }:
        let
          osOptions = (import ./dotfiles.nix { inherit config lib; }).options;
        in
        {
          options.dotfiles = osOptions.dotfiles;
          config.dotfiles = osDotfiles;
        }
      )
    ];
  };
}
