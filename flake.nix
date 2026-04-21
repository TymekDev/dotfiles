{
  description = "TymekDev's NixOS flake";

  inputs = {
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:TymekDev/nix-darwin?ref=builtin-keyboard-only";
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

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      nixpkgs-unstable,
      nix-darwin,
      disko,
      home-manager,
      nur,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        sffpc = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
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
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        maczek = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            home-manager.darwinModules.home-manager

            ./nix/machines/maczek
            ./nix/configuration/common
            ./nix/configuration/darwin
            ./nix/pkgs

            {
              dotfiles = {
                username = "tymek";
                uid = 501;
              };
            }
          ];
        };
      };

      homeConfigurations =
        let
          pkgs = import nixpkgs-unstable { system = "x86_64-linux"; };
          mkConfig =
            username:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs; };
              modules = [
                ./nix/configuration/common/dotfiles.nix
                ./nix/configuration/codespace
                ./nix/home-manager
                ./nix/pkgs

                {
                  dotfiles.username = username;
                  dotfiles.isCodespace = true;
                }
              ];
            };
        in
        {
          codespace = mkConfig "codespace";
          vscode = mkConfig "vscode";
        };
    };
}
