{ pkgs, lib, ... } :
{
  home.packages = [ pkgs.neovim ];

  home.activation.symlinkNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ln -s $VERBOSE_ARG $HOME/personal/dotfiles/config/nvim $HOME/.config/nvim
  '';
}
