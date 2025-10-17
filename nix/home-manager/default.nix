{ ... }:
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
    ./tmux.nix
    ./wezterm.nix
  ];

  xdg.enable = true;
}
