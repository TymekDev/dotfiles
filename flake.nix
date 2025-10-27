{
  description = "TymekDev's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      disko,
      home-manager,
      nur,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        sffpc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./nix/hardware-configuration/sffpc.nix

            disko.nixosModules.disko
            ./nix/disko/sffpc.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "hmbak";
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
              home-manager.users.tymek = {
                imports = [
                  ./nix/home-manager/machines/sffpc.nix
                  ./nix/home-manager/default.nix
                ];
              };
            }

            nur.modules.nixos.default

            ./nix/configuration/machines/sffpc.nix
            ./nix/configuration/default.nix
          ];
        };
      };
    };
}
