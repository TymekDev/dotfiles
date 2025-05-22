# TymekDev's dotfiles

Hey 👋 This repo holds config files for the tools that I use.
The list of tools can be found in [`Brewfile`](Brewfile).

Explore, get inspired, and beware, because _here be dragons!_
If you have any questions feel free to reach out to me at tymek.makowski@gmail.com, enjoy!

## Setup

> [!CAUTION]
> I haven't tried the MacOS setup on a clean OS yet.

<details>
<summary><h3>MacOS</h3></summary>

1. Run:
   ```sh
   xcode-select --install
   ```
1. Install [`brew`](https://brew.sh/):
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
1. Clone the repo:
   ```sh
   git clone https://github.com/TymekDev/dotfiles ~/personal/dotfiles
   git -C ~/personal/dotfiles remote set-url origin git@github.com:TymekDev/dotfiles
   ```
1. Symlink config files:
   ```sh
   make --directory ~/personal/dotfiles restow
   ```
   - ⚠️ Make sure that `~/.config/karabiner` is a symlink ([details](https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/))
1. Install programs:
   ```sh
   /opt/homebrew/bin/brew bundle --file ~/personal/dotfiles/Brewfile install
   /opt/homebrew/bin/bob use stable # installs Neovim
   ```
1. Configure [`fish`](https://fishshell.com/):
   ```sh
   echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
   chsh -s /opt/homebrew/bin/fish
   ```
1. Install WezTerm terminfo:
   ```sh
   tempfile=$(mktemp) \
     && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
     && tic -x -o ~/.terminfo $tempfile \
     && rm $tempfile
   ```
1. Open WezTerm—it should start fish and have `$PATH` properly set up
1. Start Neovim and install its plugins via `:Lazy`
1. Install by hand:
   - Tailscale: https://pkgs.tailscale.com/stable/#macos
   - Google Chrome
1. [Disable Firefox title bar](https://blog.tymek.dev/firefox-css-2)
1. Add the following snippet at the very bottom of `~/.ssh/config`:
   ```
   Host *
     IdentityAgent "SSH_AUTH_SOCK"
   ```
1. Install Neovim spell files
   - Note: Enable NetRW and disable oil.nvim to download spell files (see https://github.com/stevearc/oil.nvim/issues/163)

</details>

<details>
<summary><h3>NixOS</h3></summary>

**Note:** This uses the `sffpc` host.
Adjust the host, paths, and URIs accordingly if needed.

1. Download the minimal NixOS ISO image and create a bootable USB
1. Run the live version from the USB
1. Use [disko](https://github.com/nix-community/disko) with [`nix/disko/sffpc.nix`](./nix/disko/sffpc.nix) to partition the disk:
   1. Make sure that the `device` value in [`nix/disko/sffpc.nix`](./nix/disko/sffpc.nix) is up to date
   1. Run:
   ```sh
   curl -o /tmp/disko.nix https://raw.githubusercontent.com/TymekDev/dotfiles/main/nix/disko/sffpc.nix
   sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko.nix
   ```
   1. Verify that `mount | grep /mnt ` shows new entries for `/mnt` and `/mnt/boot`
1. _**(Only if setting up a new machine)**_ Retrieve `hardware-configuration.nix`:
   1. Run:
      ```sh
      sudo nixos-generate-config --no-filesystems --root /mnt
      ```
   1. Add `/mnt/etc/nixos/hardware-configuration.nix` to this repository
   1. Update [`flake.nix`](./flake.nix) to include the added file
   1. Push the updated version
1. Install the system:
   ```sh
   sudo nixos-install --root /mnt --flake github:TymekDev/dotfiles#sffpc --no-write-lock-file
   ```
1. Set a password for users defined in the configuration:
   ```sh
   sudo nixos-enter --root /mnt -c "passwd tymek"
   ```

<h4>Extending</h4>

To rebuild the system after making changes run:

```sh
nixos-rebuild switch --use-remote-sudo --flake .
```

**Note**: If you see an error that a file is missing, then make sure it is tracked by git.
Flakes are git-aware and the error doesn't suggest that this might be the issue.

</details>

<details>
<summary><h3>WSL</h3></summary>

1. Install WezTerm (on Windows)
1. Install WSL
   1. Open PowerShell
   1. Run `wsl --list --online` for the list of available distros
   1. Install the distro `wsl --install -d <distro>`, e.g. `wsl --install -d Ubuntu-24.04`
   1. Restart Windows
1. After Windows boots up:
   1. Set a UNIX username and password up
   1. Run: `sudo apt-get update`
   1. Run: `sudo apt-get upgrade`
1. If necessary, carry certificates over from Windows (see [Fixing WSL Certificates](https://blog.tymek.dev/fixing-wsl-certificates/#the-fix))
1. Install [`brew`](https://brew.sh/):
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
1. Clone the repo:
   ```sh
   git clone https://github.com/TymekDev/dotfiles ~/personal/dotfiles
   git -C ~/personal/dotfiles remote set-url origin git@github.com:TymekDev/dotfiles
   ```
   <!-- TODO: add a new SSH key -->
1. Symlink config files:
   ```sh
   make --directory ~/personal/dotfiles restow
   ```
1. Install programs:
   ```sh
   /home/linuxbrew/.linuxbrew/bin/brew bundle --file ~/personal/dotfiles/Brewfile install
   /home/linuxbrew/.linuxbrew/bin/bob use stable # installs Neovim
   ```
1. Configure [`fish`](https://fishshell.com/):
   ```sh
   echo "/home/linuxbrew/.linuxbrew/bin/fish" | sudo tee -a /etc/shells
   chsh -s /home/linuxbrew/.linuxbrew/bin/fish
   ```
1. Install WezTerm terminfo:
   ```sh
   tempfile=$(mktemp) \
     && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
     && tic -x -o ~/.terminfo $tempfile \
     && rm $tempfile
   ```
1. `rsync` the WezTerm config to the Windows host:
   ```fish
   rsync --delete-after --mkpath --recursive --verbose \
     config/wezterm/ \
     $(wslpath $(cmd.exe /C "echo %USERPROFILE%" 2>/dev/null | tr -d "\r"))/.config/wezterm
   ```
1. Open WezTerm—it should start fish inside WSL and have `$PATH` properly set up
1. Start Neovim and install its plugins via `:Lazy`

</details>


## Notable Commits in History

Starting with the oldest:

- Commit deleting unused configs: ([`b9d3554`][]) _chore: remove unused configs_
- Commit removing [home-manager][]: ([`2d5d745`][]) _refactor: purge home-manager and Nix_
- Commit adding setup automation using `make`: ([`7ac8ddf`][]) _Merge branch 'make-magic'_
- Commit switching from [packer.nvim][] to [lazy.nvim][]: ([`1ad9d73`][]) _Merge pull request #8 from TymekDev/lazy.nvim_
- Commit replacing the `make`-based setup with a `Brewfile`: ([`fa64d51`](https://github.com/TymekDev/dotfiles/commit/fa64d51d330a540b45bb043493706dc6b5468a8c)) _refactor: use Brewfile_
- Commit adding the NixOS configuration: ([`c844f53`](https://github.com/TymekDev/dotfiles/commit/c844f535eb858185629250faa3cda237d7ce10fc)) _Merge branch 'nixos'_

[`b9d3554`]: https://github.com/TymekDev/dotfiles/commit/b9d35545c8cac900655c77b28ea1eb28c4b3e0ce
[home-manager]: https://github.com/nix-community/home-manager
[`2d5d745`]: https://github.com/TymekDev/dotfiles/commit/2d5d74539d6d9e3f77b0ebee929179ddf1538112
[`7ac8ddf`]: https://github.com/TymekDev/dotfiles/commit/7ac8ddfef4f80cf7da00452e4f4b3777b2b016f1
[packer.nvim]: https://github.com/wbthomason/packer.nvim
[lazy.nvim]: https://github.com/folke/lazy.nvim
[`1ad9d73`]: https://github.com/TymekDev/dotfiles/commit/1ad9d73abd3099247377322dea3b3524c8dd77f3

## Known Issues

- Karabiner does not really work for porting. Another Mac's keyboard has a different identifier?

## License

**Disclaimer:** I am not an author of the image at `local/share/wallpaper.webp` and I do not claim any rights to it.

[MIT License](LICENSE.md)
