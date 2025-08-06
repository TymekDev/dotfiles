{ pkgs, ... } :
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
    ripgrep
    telegram-desktop
    tofi # dynamic menu for hyprland
    yazi
  ];

  environment.variables = {
    EDITOR = "nvim";
    TZ = "Europe/Warsaw";
  };
}
