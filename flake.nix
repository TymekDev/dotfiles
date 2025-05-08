{
  description = "TymekDev's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, disko, ... } @ inputs:
    {
      nixosConfigurations = {
        sffpc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware-configuration/sffpc.nix

            disko.nixosModules.disko
            ./disko/sffpc.nix

            ./configuration/machines/sffpc.nix
            ./configuration/1password.nix
            ./configuration/fish.nix
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
