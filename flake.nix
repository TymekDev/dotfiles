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

    mac-app-util.url = "github:hraban/mac-app-util";

    opencode = {
      # TODO: change to master once https://github.com/NixOS/nixpkgs/pull/501259 is merged
      url = "github:anomalyco/opencode?ref=0d6c60136562cca785b428aed446428d61f42616";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nix-darwin,
      disko,
      home-manager,
      nur,
      mac-app-util,
      opencode,
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
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        maczek = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit opencode; };
          modules = [
            home-manager.darwinModules.home-manager
            mac-app-util.darwinModules.default
            {
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
            }

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

      apps.${system}.rebuild-codespace =
        let
          pkgs = import nixpkgs-unstable { system = "x86_64-linux"; };
        in
        {
          type = "app";
          program = toString (
            pkgs.writeShellScript "codespace-switch" ''
              set -euo pipefail
              exec nix \
                run github:nix-community/home-manager \
                --experimental-features 'flakes nix-command' \
                -- \
                switch --flake "${self}#''$(whoami)" \
                --experimental-features 'flakes nix-command'
            ''
          );
        };
    };
}
