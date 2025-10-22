{
  description = "TymekDev's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
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
      darwin,
      disko,
      home-manager,
      nur,
      ...
    }:
    {
      nixosConfigurations = {
        sffpc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nix/hardware-configuration/sffpc.nix

            disko.nixosModules.disko
            ./nix/disko/sffpc.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "hmbak";
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
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

      darwinConfigurations = {
        maczek = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            {
              home-manager.backupFileExtension = "hmbak";
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.tymek = {

                imports = [
                  ./nix/home-manager/machines/maczek.nix
                  ./nix/home-manager/bat.nix
                ];
              };
            }

            ./nix/configuration/machines/maczek.nix
          ];
        };
      };
    };
}
