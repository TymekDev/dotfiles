{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
  mkSymlink =
    path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.home}/personal/dotfiles/${path}";
in
{
  xdg.configFile."nvim".source = if isCodespace then ../../config/nvim else mkSymlink "config/nvim";

  xdg.configFile."nvim-nix/plugin/tree-sitter-parsers.lua".text =
    let

      parsers =
        with pkgs.vimPlugins.nvim-treesitter-parsers;
        [
          css
          html
          javascript
          json
          markdown
          markdown_inline
          r
          rnoweb
          scss
          typescript
          yaml
        ]
        ++ lib.optionals (!isCodespace) [
          astro
          bash
          fish
          go
          lua
          nix
          python
          rust
          templ
          toml

        ];
      quote = (x: ''"${x}"'');
    in
    ''
      vim.opt.runtimepath:append({
      ${lib.concatMapStringsSep ",\n" quote parsers}
      })
    '';

  home.packages =
    with pkgs;
    [
      neovim

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
