{ config, ... }:
let
  osDotfiles = config.dotfiles;
in
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hmbak";
    users.${config.dotfiles.username}.imports = [
      ../../home-manager

      (
        {
          config,
          pkgs,
          lib,
          ...
        }:
        let
          osOptions = (import ./dotfiles.nix { inherit config pkgs lib; }).options;
        in
        {
          options.dotfiles = osOptions.dotfiles;
          config.dotfiles = osDotfiles;
        }
      )
    ];
  };
}
