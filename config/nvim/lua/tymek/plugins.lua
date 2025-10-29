return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      parser_configs.scss.install_info.url = "https://github.com/TymekDev/tree-sitter-scss"
      parser_configs.scss.install_info.revision = "master"

      require("nvim-treesitter.configs").setup({
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
  {
    "tpope/vim-rsi",
    config = function()
      vim.keymap.del("i", "<C-X><C-A>")
    end,
  },
  "tpope/vim-eunuch",
  "tpope/vim-abolish",
}
