# dotfiles

## Setup

1. Clone this repository and its submodules: `git clone --recurse-submodules git@github.com:TymekDev/dotfiles`
1. Install (I use latest versions):
    - Neovim (nightly)
    - fish
    - tmux
    - kitty
    - exa
    - fzf
1. Run `make` to restow config files
1. Run `:PackerSync` in Neovim
1. Run `<prefix>I` in tmux

## Notable Commits in History

- Commit deleting unused configs: ([`b9d3554`][]) _chore: remove unused configs_
- Commit removing [home-manager][]: ([`2d5d745`][]) _refactor: purge home-manager and Nix_

[`b9d3554`]: https://github.com/TymekDev/dotfiles/commit/b9d35545c8cac900655c77b28ea1eb28c4b3e0ce
[home-manager]: https://github.com/nix-community/home-manager
[`2d5d745`]: https://github.com/TymekDev/dotfiles/commit/2d5d74539d6d9e3f77b0ebee929179ddf1538112

## Contact

If you have any questions feel free to reach out to me at tymek.makowski@gmail.com.

## License

**Disclaimer:** I am not an author of the image at `local/share/wallpaper.webp` and I do not claim any rights to it.

[MIT License](LICENSE.md)
