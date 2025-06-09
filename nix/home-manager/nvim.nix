{ pkgs, lib, ... } :
{
  home.packages = [ pkgs.neovim ];

  home.activation.symlinkNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run [ ! -L ~/.config/nvim ] && ln -s $VERBOSE_ARG $HOME/personal/dotfiles/config/nvim/ -t $HOME/.config/ || exit 0
  '';
}
