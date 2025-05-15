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
  };

  outputs =
    { self, nixpkgs, disko, home-manager, ... } @ inputs:
    {
      nixosConfigurations = {
        sffpc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware-configuration/sffpc.nix

            disko.nixosModules.disko
            ./disko/sffpc.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "hmbak";
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.tymek = {
                imports = [
                  ./home-manager/machines/sffpc.nix
                  ./home-manager/hyprland.nix
                ];
              };
            }

            ./configuration/machines/sffpc.nix
            ./configuration/1password.nix
            ./configuration/environment.nix
            ./configuration/fish.nix
            ./configuration/fonts.nix
            ./configuration/fzf.nix
            ./configuration/git.nix
            ./configuration/hyprland.nix
            ./configuration/nix.nix
            ./configuration/starship.nix
            ./configuration/tmux.nix
          ];
        };
      };
    };
}
