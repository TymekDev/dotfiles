{ pkgs, ... } :
{
  home.packages = [ pkgs.neovim ];

  xdg.configFile."nvim" = {
    source = ../../config/nvim;
    recursive = true;
  };
}
