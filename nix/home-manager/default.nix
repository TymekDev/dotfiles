{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
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

  # TODO: split desktop apps like Discord and Spotify?
  home.packages = with pkgs; [
    discord
    fd
    gh
    git-absorb
    go-task
    ijq
    jq
    nodejs_22
    opencode
    ripgrep
    spotify
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
    jj
  ];

  xdg.enable = true;

  home.stateVersion = "24.11";
}
