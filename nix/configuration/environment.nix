{ pkgs, ... } :
{
  environment.systemPackages = with pkgs; [
    neovim
    tofi # dynamic menu for hyprland
  ];

  environment.variables = {
    EDITOR = "nvim";
  };
}
