{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
  inherit (pkgs.stdenv) isDarwin isLinux;

  mkSymlink =
    path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.home}/personal/dotfiles/${path}";
in
{
  imports = [
    ./desktops/sway
    ./terminals/ghostty
    ./terminals/wezterm
    ./bat.nix
    ./direnv.nix
    ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./hammerspoon.nix
    ./jj.nix
    ./nvim.nix
    ./opencode.nix
    ./rclone.nix
    ./ssh.nix
    ./starship.nix
  ];

  home.sessionVariables = lib.optionalAttrs isDarwin {
    SSH_AUTH_SOCK = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };

  home.packages =
    with pkgs;
    [
      arf
      fd
      gh
      git-absorb
      go-task
      ijq
      jq
      nodejs_22
      ripgrep
      yazi

      # my custom stuff
      are-we-dark-yet
    ]
    # TODO: migrate this into home-manager modules
    ++ lib.optionals isDarwin [
      jujutsu
      tarsnap-1pass
      tarsnap-1pass-backup
    ]
    ++ lib.optionals (isLinux && !isCodespace) [
      discord
      spotify
      tarsnap-1pass
      tarsnap-1pass-backup
    ];

  xdg.enable = true;
  xdg.configFile = lib.mkIf isDarwin {
    "karabiner".source = mkSymlink "config/karabiner";
    "linearmouse".source = mkSymlink "config/linearmouse";
  };

  home.stateVersion = "24.11";
}
