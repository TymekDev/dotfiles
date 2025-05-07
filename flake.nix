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
            disko.nixosModules.disko
            ./disko/sffpc.nix
            {
              boot.loader.systemd-boot.enable = true;
              boot.loader.efi.canTouchEfiVariables = true;
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
