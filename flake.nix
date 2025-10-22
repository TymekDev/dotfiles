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
          specialArgs = {
            isDarwin = false;
            isLinux = true;
          };
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
          specialArgs = {
            isDarwin = true;
            isLinux = false;
          };
          modules = [
            home-manager.darwinModules.home-manager
            {
              home-manager.backupFileExtension = "hmbak";
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.tymek = {
                home.activation.symlinkGit = home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                  run [ ! -L ~/.config/git ] && ln -s $VERBOSE_ARG $HOME/personal/dotfiles/config/git/ -t $HOME/.config/ || exit 0
                '';

                imports = [
                  ./nix/home-manager/machines/maczek.nix
                  ./nix/home-manager/bat.nix
                  ./nix/home-manager/fish.nix
                  ./nix/home-manager/fzf.nix
                  ./nix/home-manager/nvim.nix
                  ./nix/home-manager/starship.nix
                  ./nix/home-manager/tmux.nix
                  ./nix/home-manager/wezterm.nix
                ];
              };
            }

            ./nix/configuration/machines/maczek.nix
            ./nix/configuration/default.nix
          ];
        };
      };
    };
}
