# TymekDev's dotfiles

Hey 👋 This repo holds config files for the tools that I use.
The list of tools can be found at the top of [`Makefile`][].

[`Makefile`]: Makefile

Explore, get inspired, and beware, because _here be dragons!_
If you have any questions feel free to reach out to me at tymek.makowski@gmail.com, enjoy!

## Setup

Currently I exclusively use MacOS, therefore [`Makefile`][] heavily relies on [`brew`][].

[`brew`]: https://brew.sh/

The minimal setup can be done using:

```sh
make dotfiles
```

Running `make dotfiles` will:
- force install [tpm][] (`~/.config/tmux/plugins/tpm` gets deleted before cloning)
- install `brew` if it is missing
- install `stow` if it is missing
- run `stow` to place [`config`](config) and [`local`](local) contents into `~/.config` and `~/.local` respectively
- source `~/.config/tmux/tmux.conf` configuration if `tmux` is running
- install `tmux` plugins

[tpm]: https://github.com/tmux-plugins/tpm

### Install on Clean OS

If you have a clean MacOS, then the following commands will get you up to speed:

```sh
xcode-select --install
mkdir ~/personal
git clone https://github.com/TymekDev/dotfiles ~/personal/dotfiles
cd ~/personal/dotfiles
make from-scratch
```

In addition to what `make dotfiles` does, `make from-scratch` installs all tools and sets `fish` to be the default shell.

### Additional `make` Targets

Other than `dotfiles` and `from-scratch`, the following targets are available:
- `restow` - runs `stow --restow` to update or place configs in place
- `unstow` - runs `stow --delete` to undo `restow` target
- `install` - installs everything with `install-` prefix
- `install-*` - numerous targets for installing tools, one at a time

### Manual Tweaks

- [Disable Firefox title bar][]

[Disable Firefox title bar]: https://blog.tymek.dev/firefox-css-2

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
Some are listed in [`Makefile`][]. Additionally:

- Karabiner does not really work for porting. Another Mac's keyboard has a
  different identifier?

## License

**Disclaimer:** I am not an author of the image at `local/share/wallpaper.webp` and I do not claim any rights to it.

[MIT License](LICENSE.md)
