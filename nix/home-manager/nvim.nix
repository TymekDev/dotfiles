{ pkgs, lib, ... } :
{
  # TODO: does this get joined if I have `home.packages = [ foo ];` in another place?
  home.packages = [ pkgs.neovim ];

  home.activation.symlinkNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run [ ! -L ~/.config/nvim ] && ln -s $VERBOSE_ARG $HOME/personal/dotfiles/config/nvim/ -t $HOME/.config/ || exit 0
  '';
}
