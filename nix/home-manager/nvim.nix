{
  config,
  pkgs,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
  mkSymlink =
    path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.home}/personal/dotfiles/${path}";
in
{
  xdg.configFile."nvim".source = if isCodespace then ../../config/nvim else mkSymlink "config/nvim";

  home.packages = with pkgs; [
    gcc # used by nvim-treesitter to install grammars
    neovim

    # Language servers
    lua-language-server
    nixd
    vscode-langservers-extracted

    # Formatters
    nixfmt
    stylua
  ];

  home.sessionVariables.EDITOR = "nvim";
}
