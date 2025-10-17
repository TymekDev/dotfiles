{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    fd
    gcc # used by nvim-treesitter to install grammars
    gh
    git-absorb
    go-task
    ijq
    jq
    nodejs_22
    ripgrep
    tofi # dynamic menu for hyprland
    uhk-agent
    yazi
  ];
}
