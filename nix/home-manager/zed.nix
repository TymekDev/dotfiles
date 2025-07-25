{ pkgs-unstable, lib, ... } :
{
  home.packages = [ pkgs-unstable.zed-editor ];

  home.activation.symlinkZed = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run [ ! -L ~/.config/zed ] && ln -s $VERBOSE_ARG $HOME/personal/dotfiles/config/zed/ -t $HOME/.config/ || exit 0
  '';
}
