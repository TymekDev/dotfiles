{ pkgs, ... }:
{
  imports = [
    ./desktops/sway
    ./terminals/ghostty.nix
    ./terminals/wezterm.nix
    ./bat.nix
    ./direnv.nix
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
    ./tmux.nix
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
    tarsnap-1pass-backup
  ];

  xdg.enable = true;

  home.stateVersion = "24.11";
}
