{ config, lib, pkgs, ... }:

{
  home = {
    username = "tmakowski";
    homeDirectory = "/home/tmakowski";
    stateVersion = "22.05";
    packages = with pkgs; [
      asciinema
      betterlockscreen
      blueman
      cz-cli
      curl
      delta
      entr
      firefox
      fish
      flameshot
      fzf
      gimp
      go_1_17
      htop
      hugo
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
  };

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };

    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Tymoteusz Makowski";
      aliases = {
        # [d]iff [c]ommit
        dc = "! f() { REF=\${1:-HEAD}; if [ $# -ge 1 ]; then shift 1; fi; git diff $REF~1 $REF $@; }; f";
        # [d]elete [m]erged
        dm = "! git branch --merged | grep -vE '(\\*|main|master)' | xargs -n 1 git branch -d";
        # [f]ind [c]ode ([s]ingle)
        fc = "fl --all -S";
        fcs = "fl -S";
        # [f]ormat [l]og
        fl = "log --format='%C(yellow)%h  %C(blue)%ad  %C(auto)%s  %C(cyan)<%cn> %C(auto)%d' --date=short";
        # [g]raph ([s]ingle)
        g  = "fl --graph --all";
        gs = "fl --graph";
        # [l]ast [b]ranches | Source: https://ses4j.github.io/2020/04/01/git-alias-recent-branches/
        lb = "! git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep 'checkout:' | grep -oE '[^ ]+ ~ .*' | awk -F~ '! seen[$1]++' | head -n 10 | awk -F' ~ HEAD@{' '{printf(\"  \\033[33m%s: \\033[37m %s\\033[0m\\n\", substr($2, 1, length($2)-1), $1)}'";
        # [p]ush [o]rigin
        po = "! f() { git push -u origin $(git branch --show-current); }; f";
      };
      delta = {
        enable = true;
        options = {
          line-numbers = true;
          navigate = true;
          theme = "gruvbox-dark";
        };
      };
      extraConfig = {
        core.editor = "vim";
        credential.helper = "store";
        init.templateDir = "~/.config/git/template";
        pull.rebase = false;
      };
      includes = [
        {
          condition = "gitdir:~/projects/**";
          contents.user.email = "t@makowski.sh";
        }
        {
          condition = "gitdir:~/work/**";
          contents.user.email = "tymoteusz@appsilon.com";
        }
      ];
    };

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

  xdg = {
    configFile."git/template" = {
      source = ./config/git/template;
      recursive = true;
    };

    dataFile.wallpaper = {
      source = ./config/wallpaper;
      onChange = "${pkgs.betterlockscreen}/bin/betterlockscreen --update ${config.xdg.dataFile.wallpaper.target} --fx dimblur";
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "nixGL kitty";
      modifier = "Mod4";
      fonts = {
        names = [ "JetBrains Mono" ];
        size = 12.0;
      };
      keybindings = let mod = config.xsession.windowManager.i3.config.modifier; in lib.mkOptionDefault {
        # Movement
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        # Focus
        "${mod}+x" = "focus child";
        # Split direction
        "${mod}+v" = "split h";
        "${mod}+Shift+v" = "split v";
        # Layouts
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        # Misc
        "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
        # TODO: "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi";
        # FIXME: system auth does not appear to work
        # "${mod}+BackSpace" = "exec ${pkgs.betterlockscreen}/bin/betterlockscreen -l dimblur";
        "${mod}+backslash" = "exec ${pkgs.firefox}/bin/firefox";
        "${mod}+Shift+s" = "exec ${pkgs.i3}/bin/i3-nagbar -t warning -m 'Do you want shutdown system?' -B 'Yes, shutdown system' 'systemctl poweroff'";
      };
      modes.resize = {
        "h" = "resize shrink width 5 px or 5 ppt";
        "j" = "resize shrink height 5 px or 5 ppt";
        "k" = "resize grow height 5 px or 5 ppt";
        "l" = "resize grow width 5 px or 5 ppt";
        "Shift+h" = "resize shrink width 15 px or 15 ppt";
        "Shift+j" = "resize shrink height 15 px or 15 ppt";
        "Shift+k" = "resize grow height 15 px or 15 ppt";
        "Shift+l" = "resize grow width 15 px or 15 ppt";
        "Escape" = "mode default";
        "${config.xsession.windowManager.i3.config.modifier}+r" = "mode default";
      };
      startup = [
        { command = "nm-applet"; notification = false; }
        { command = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --primary"; notification = false; }
        { command = "${pkgs.betterlockscreen}/bin/betterlockscreen --wall"; notification = false; }
      ];
      window = {
        commands = [
          { command = "border pixel 1"; criteria.class = "^.*"; }
          { command = "floating enable"; criteria.class="Nautilus"; }
          { command = "floating enable"; criteria.class="Steam"; }
          { command = "floating enable"; criteria.class="Lutris"; }
          { command = "floating enable"; criteria.class="galaxyclient"; }
          { command = "floating disable"; criteria.class="Wine"; }
        ];
        hideEdgeBorders = "smart";
      };
      workspaceOutputAssign = [
        { workspace = "1"; output = "DP-2"; }
        { workspace = "2"; output = "DP-2"; }
        { workspace = "3"; output = "DP-2"; }
        { workspace = "4"; output = "DP-2"; }
        { workspace = "5"; output = "DP-2"; }
        { workspace = "6"; output = "DP-1"; }
        { workspace = "7"; output = "DP-1"; }
        { workspace = "8"; output = "DP-1"; }
        { workspace = "9"; output = "DP-1"; }
        { workspace = "10"; output = "DP-1"; }
      ];
    };
  };
}