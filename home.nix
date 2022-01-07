{ config, pkgs, ... }:

{
  home = {
    username = "tmakowski";
    homeDirectory = "/home/tmakowski";
    stateVersion = "22.05";
  };

  home.packages = with pkgs; [
    asciinema
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

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };

    home-manager.enable = true;

    kitty = {
      enable = true;
      font = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
        size = 12;
      };
      extraConfig = ''
        # https://github.com/rsaihe/gruvbox-material-kitty/blob/main/colors/gruvbox-material-dark-medium.conf
        background #282828
        foreground #d4be98
        selection_background #d4be98
        selection_foreground #282828
        cursor #a89984
        cursor_text_color background
        active_tab_background #282828
        active_tab_foreground #d4be98
        active_tab_font_style bold
        inactive_tab_background #282828
        inactive_tab_foreground #a89984
        inactive_tab_font_style normal
        color0 #665c54
        color8 #928374
        color1 #ea6962
        color9 #ea6962
        color2 #a9b665
        color10 #a9b665
        color3 #e78a4e
        color11 #d8a657
        color4 #7daea3
        color12 #7daea3
        color5 #d3869b
        color13 #d3869b
        color6 #89b482
        color14 #89b482
        color7 #d4be98
        color15 #d4be98
      '';
    };
  };
}
