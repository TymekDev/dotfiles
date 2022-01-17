# dotfiles _the Nix way_

dotfiles rewritten to use [home-manager] to install programs and manage their configuration files
based on a single [`home.nix`](home.nix). Inspired by [Alex Pearce's dotfiles] and [his blog post].

A last commit without home-manager was [`10a3d35`].


## Setup
1. [Install Nix]
1. [Install Home Manager]
1. [Install nixGL] - non-Nix drivers are not recognized by Nix [kitty], see [#80936]
1. Clone this repository: `git clone --recurse-submodules git@github:tmakowski/dotfiles ~/.config/nixpkgs`
1. Build [home-manager] configuration: `home-manager switch`

### Enable fish
Make sure `which fish` returns Nix version of `fish`.
```
which fish | sudo tee -a /etc/shells
chsh -s `which fish`
```


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
