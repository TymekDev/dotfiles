{ pkgs, ... }:
{
  imports = [
    ./machines/sffpc.nix
    ./bat.nix
    ./darkman.nix
    ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./nvim.nix
    ./obs.nix
    ./starship.nix
    ./sway.nix
    ./tmux.nix
    ./wezterm.nix
  ];

  home.packages = with pkgs; [
    discord
    fd
    gh
    git-absorb
    go-task
    ijq
    jq
    nodejs_22
    ripgrep
    uhk-agent
    yazi
  ];

  xdg.enable = true;
}
