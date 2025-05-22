{ pkgs, ... } :
{
  environment.systemPackages = with pkgs; [
    gcc
    neovim
    telegram-desktop
    tofi # dynamic menu for hyprland
  ];

  environment.variables = {
    EDITOR = "nvim";
  };
}
