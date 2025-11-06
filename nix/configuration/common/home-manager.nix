{ pkgs-unstable, ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hmbak";
    extraSpecialArgs = { inherit pkgs-unstable; };
    users.tymek.imports = [ ../../home-manager ];
  };
}
