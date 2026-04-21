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
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server

      # Formatters
      air-formatter
      prettierd
      yamlfmt
    ]
    ++ lib.optionals (!isCodespace) [
      gcc # used by nvim-treesitter to install grammars

      # Language servers
      astro-language-server
      bash-language-server
      emmet-language-server
      fish-lsp
      golangci-lint-langserver
      gopls
      lua-language-server
      nixd
      nodePackages.unocss-language-server
      tailwindcss-language-server
      taplo
      templ

      # Formatters
      nixfmt
      ruff
      rustfmt
      shellcheck
      shfmt
      stylua
    ];

  home.sessionVariables.EDITOR = "nvim";
}
