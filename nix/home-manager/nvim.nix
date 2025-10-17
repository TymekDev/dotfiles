{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    gcc # used by nvim-treesitter to install grammars
    neovim
  ];

  home.activation.symlinkNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run [ ! -L ~/.config/nvim ] && ln -s $VERBOSE_ARG $HOME/personal/dotfiles/config/nvim/ -t $HOME/.config/ || exit 0
  '';

  home.sessionVariables.EDITOR = "nvim";
}
