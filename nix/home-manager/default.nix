{ pkgs, ... }:
{
  imports = [
    ./desktops/sway
    ./bat.nix
    ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./jj.nix
    ./nvim.nix
    ./obs.nix
    ./rclone.nix
    ./ssh.nix
    ./starship.nix
    ./sway.nix
    ./tmux.nix
    ./waybar.nix
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
    spotify
    uhk-agent
    yazi

    # my custom stuff
    tarsnap-1pass
  ];

  xdg.enable = true;

  home.stateVersion = "24.11";
}
