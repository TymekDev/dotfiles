{ pkgs, ... } :
{
  environment.systemPackages = with pkgs; [
    discord
    gcc
    neovim
    telegram-desktop
    tofi # dynamic menu for hyprland
  ];

  environment.variables = {
    EDITOR = "nvim";
  };
}
