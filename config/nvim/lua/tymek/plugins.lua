return {
  {
    "folke/tokyonight.nvim",
    priority = 999,
    config = function()
      require("tokyonight").setup({
        lualine_bold = true,
        on_highlights = function(hl, _)
          hl["@r.reactive.call"] = { link = "Special" }
          hl["@r.box.unused.import"] = { link = "Error" }
          hl.NvimSurroundHighlight = { link = "IncSearch" }
        end,
      })

      require("tymek.theme").update()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      parser_configs.scss.install_info.url = "https://github.com/TymekDev/tree-sitter-scss"
      parser_configs.scss.install_info.revision = "master"

      require("nvim-treesitter.configs").setup({
        -- Make sure the comment parser gets never installed. See:
        --  - https://github.com/folke/ts-comments.nvim/issues/55#issuecomment-2363200467
        --  - https://github.com/folke/ts-comments.nvim/discussions/57
        ignore_install = { "comment" },
        auto_install = true,
        highlight = { enable = true },
      })

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      max_lines = 5,
    },
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        fast_wrap = {},
      })
    end,
  },
  "junegunn/vim-easy-align", -- TODO: review config
  {
    "tpope/vim-rsi",
    config = function()
      vim.keymap.del("i", "<C-X><C-A>")
    end,
  },
  "tpope/vim-eunuch",
  "tpope/vim-abolish",
}
