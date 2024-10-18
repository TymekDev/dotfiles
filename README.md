# TymekDev's dotfiles

Hey 👋 This repo holds config files for the tools that I use.
The list of tools can be found in [`Brewfile`](Brewfile).

Explore, get inspired, and beware, because _here be dragons!_
If you have any questions feel free to reach out to me at tymek.makowski@gmail.com, enjoy!

## Setup

### MacOS

> [!CAUTION]
> I haven't tried this setup on a clean OS yet.

<details>
<summary><strong>Steps</strong></summary>

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
   make --directory ~/personal/dotfiles
   ```
   - ⚠️ Make sure that `~/.config/karabiner` is a symlink ([details](https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/))
1. Run:
   ```sh
   brew bundle install
   ```
1. Configure [`fish`](https://fishshell.com/):
   ```sh
   echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
   chsh -s /opt/homebrew/bin/fish
   ```
1. Start Neovim and install its plugins:
   ```sh
   nvim
   ```
1. Install WezTerm terminfo:
   ```sh
   tempfile=$(mktemp) \
     && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
     && tic -x -o ~/.terminfo $tempfile \
     && rm $tempfile
   ```
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

## Notable Commits in History

- Commit deleting unused configs: ([`b9d3554`][]) _chore: remove unused configs_
- Commit removing [home-manager][]: ([`2d5d745`][]) _refactor: purge home-manager and Nix_
- Commit adding setup automation using `make`: ([`7ac8ddf`][]) _Merge branch 'make-magic'_
- Commit switching from [packer.nvim][] to [lazy.nvim][]: ([`1ad9d73`][]) _Merge pull request #8 from TymekDev/lazy.nvim_

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
