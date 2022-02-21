# dotfiles _the Nix way_

dotfiles rewritten to use [home-manager] to install programs and manage their configuration files
based on a single [`home.nix`](home.nix). Inspired by [Alex Pearce's dotfiles] and [his blog post].

A last commit without home-manager was [`10a3d35`].


## Setup
1. [Install Nix]
1. [Install Home Manager]
1. [Install nixGL] - non-Nix drivers are not recognized by Nix [kitty], see [#80936]
1. Clone this repository: `git clone git@github.com:tmakowski/dotfiles ~/.config/nixpkgs`
1. Build [home-manager] configuration: `home-manager switch`
1. [Install Neovim from source]
1. [Install vim-plug]
1. Symlink Neovim config: `ln -s ~/.config/nixpkgs/nvim ~/.config/nvim`

### Enable fish
Make sure `which fish` returns Nix version of `fish`.
```
which fish | sudo tee -a /etc/shells
chsh -s `which fish`
```

### Neovim
I had it initially handled with home-manager, however making quick changes was harder due to config
files handled by home-manager being read-only. Therefore, I changed it to be symlinked.

Last commit prior to this change was [`8966a8a`].


## Contact
If you have any questions feel free to reach out to me at t@makowski.sh.


## License
**Disclaimer:** I am not an author of the image at `share/wallpaper.jpg` and I do not claim any rights to it.

[MIT License](LICENSE.md)


<!-- Links -->
[home-manager]: https://github.com/nix-community/home-manager
[Alex Pearce's dotfiles]: https://github.com/alexpearce/dotfiles/
[his blog post]: https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
[`10a3d35`]: https://github.com/tmakowski/dotfiles/tree/10a3d353cbb55a5715f5dd62c95098a51db34b0d
[Install Nix]: https://nixos.org/download.html#nix-quick-install
[Install Home Manager]: https://github.com/nix-community/home-manager#installation
[Install nixGL]: https://github.com/guibou/nixGL
[kitty]: https://github.com/kovidgoyal/kitty
[#80936]: https://github.com/NixOS/nixpkgs/issues/80936
[Install Neovim from source]: https://github.com/neovim/neovim/wiki/Building-Neovim
[Install vim-plug]: https://github.com/junegunn/vim-plug
[`8966a8a`]: https://github.com/tmakowski/dotfiles/tree/8966a8a8ff0236a6d86d5db53a7c7e5da61064c8
