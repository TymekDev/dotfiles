## Setup

> [!NOTE]
> This uses the `sffpc` host and `nixos` branch.
> Adjust the host, paths, and URIs accordingly if needed.

1. Download the minimal NixOS ISO image and create a bootable USB
1. Run the live version from the USB
1. Use [disko](https://github.com/nix-community/disko) with [`disko/sffpc.nix`](./disko/sffpc.nix) to partition the disk:
   1. Make sure that the `device` value in [`disko/sffpc.nix`](./disko/sffpc.nix) is up to date
   1. Run:
   ```sh
   curl -o /tmp/disko.nix https://raw.githubusercontent.com/TymekDev/dotfiles/nixos/disko/sffpc.nix
   sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko.nix
   ```
   1. Verify that `mount | grep /mnt ` shows new entries for `/mnt` and `/mnt/boot`
1. _**(Only if setting a new machine)**_ Retrieve `hardware-configuration.nix`:
   1. Run:
      ```sh
      sudo nixos-generate-config --no-filesystems --root /mnt
      ```
   1. Add `/mnt/etc/nixos/hardware-configuration.nix` to this repository
   1. Update [`flake.nix`](./flake.nix) to include the added file
   1. Push the updated version
1. Install the system:
   ```sh
   sudo nixos-install --root /mnt --flake github:TymekDev/dotfiles/nixos#sffpc --no-write-lock-file
   ```
1. Set a password for users defined in the configuration:
   ```sh
   sudo nixos-enter --root /mnt -c "passwd tymek"
   ```
