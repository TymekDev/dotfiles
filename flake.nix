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

            {
              boot.loader.grub = {
                enable = true;
                efiSupport = true;
                efiInstallAsRemovable = true;
              };
              system.stateVersion = "24.11";
              users.users.tymek = {
                isNormalUser = true;
                home = "/home/tymek";
                extraGroups = [ "wheel" "networkmanager" ];
              };
            }
          ];
        };
      };
    };
}
