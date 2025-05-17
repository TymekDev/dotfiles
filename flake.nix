{
  description = "TymekDev's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, disko, home-manager, nur, ... } @ inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        sffpc = nixpkgs.lib.nixosSystem {
          inherit system;
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
                xdg.enable = true;
                imports = [
                  ./nix/home-manager/machines/sffpc.nix
                  ./nix/home-manager/firefox.nix
                  ./nix/home-manager/hyprland.nix
                  ./nix/home-manager/hyprpaper.nix
                  ./nix/home-manager/tmux.nix
                  ./nix/home-manager/wezterm.nix
                ];
              };
            }

            nur.modules.nixos.default

            ./nix/configuration/machines/sffpc.nix
            ./nix/configuration/1password.nix
            ./nix/configuration/environment.nix
            ./nix/configuration/fish.nix
            ./nix/configuration/fonts.nix
            ./nix/configuration/fzf.nix
            ./nix/configuration/git.nix
            ./nix/configuration/hyprland.nix
            ./nix/configuration/i18n.nix
            ./nix/configuration/nix.nix
            ./nix/configuration/starship.nix
          ];
        };
      };
    };
}
