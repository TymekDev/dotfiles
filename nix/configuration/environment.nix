{ pkgs, ... } :
{
  environment.systemPackages = with pkgs; [
    gcc
    neovim
    tofi # dynamic menu for hyprland
  ];

  environment.variables = {
    EDITOR = "nvim";
  };
}
