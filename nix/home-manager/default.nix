{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;

  mkSymlink =
    path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.home}/personal/dotfiles/${path}";
in
{
  imports = [
    ./desktops/sway
    ./terminals/wezterm
    ./bat.nix
    ./direnv.nix
    ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./jj.nix
    ./nvim.nix
    ./rclone.nix
    ./ssh.nix
    ./starship.nix
  ];

  home.packages =
    with pkgs;
    [
      fd
      gh
      git-absorb
      go-task
      ijq
      jq
      nodejs_22
      opencode
      ripgrep
      yazi

      # my custom stuff
      tarsnap-1pass
      tarsnap-1pass-backup
    ]
    # TODO: migrate this into home-manager modules
    ++ lib.optionals isDarwin [
      difftastic
      eza
      git
      jujutsu
    ]
    ++ lib.optionals isLinux [
      discord
      spotify
    ];

  xdg.enable = true;
  xdg.configFile = lib.mkIf isDarwin {
    "karabiner".source = mkSymlink "config/karabiner";
    "linearmouse".source = mkSymlink "config/linearmouse";
  };

  home.stateVersion = "24.11";
}
