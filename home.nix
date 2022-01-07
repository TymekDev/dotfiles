{ config, pkgs, ... }:

{
  home = {
    username = "tmakowski";
    homeDirectory = "/home/tmakowski";
    stateVersion = "22.05";
  };

  home.packages = with pkgs; [
    asciinema
    bat
    betterlockscreen
    blueman
    curl
    delta
    entr
    feh
    # TODO: firefox
    fish
    flameshot
    fzf
    gimp
    git
    go_1_17
    htop
    hugo
    i3
    i3status
    jq
    kazam
    kitty
    moreutils
    mpv
    ncdu
    pandoc
    pavucontrol
    python3
    ripgrep
    # TODO: rofi
    sqlite
    tdesktop
    tree
    universal-ctags
    unzip
    vim
    wine
    zip
    zsh
    # TODO: install unfree packages
    # discord
    # steam
  ];

  programs.home-manager.enable = true;
}
