{
  description = "TymekDev's NixOS flake";

  inputs = {
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixos-unstable";
    };
  };

  outputs =
    {
      nixpkgs-unstable,
      nix-darwin,
      disko,
      home-manager,
      nur,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        sffpc = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            nur.modules.nixos.default

            ./nix/machines/sffpc
            ./nix/configuration/common
            ./nix/configuration/nixos
            ./nix/pkgs

            {
              dotfiles = {
                username = "tymek";
                desktop = "sway";
                gaming = [
                  "osrs"
                ];
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        maczek = nix-darwin.lib.darwinSystem {
          modules = [
            ({pkgs, ...}:{
              nix.settings.experimental-features = [
                "flakes"
                "nix-command"
              ];
              nixpkgs.hostPlatform = "aarch64-darwin";
              programs.fish.enable = true;
              system.stateVersion = 6;
              users.knownUsers = ["tymek"];
              users.users.tymek = {
                uid = 501;
                home = "/Users/tymek";
                shell = pkgs.fish;
              };
            })
          ];
        };
      };
    };
}
