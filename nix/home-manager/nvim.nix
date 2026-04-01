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

  home.packages =
    with pkgs;
    [
      neovim
      tree-sitter # TODO: switch to installing compiled grammars directly?

      # Language servers
      astro-language-server
      bash-language-server
      emmet-language-server
      fish-lsp
      lua-language-server
      nixd
      tailwindcss-language-server
      taplo
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server

      # Formatters
      nixfmt
      prettierd
      ruff
      shellcheck
      shfmt
      stylua
      yamlfmt
    ]
    ++ lib.optionals (!isCodespace) [
      gcc # used by nvim-treesitter to install grammars
    ];

  home.sessionVariables.EDITOR = "nvim";
}
