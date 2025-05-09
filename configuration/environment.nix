{ pkgs, ... } :
{
  environment.systemPackages = with pkgs; [
    neovim
  ];

  environment.variables = {
    EDITOR = "nvim";
  };
}
