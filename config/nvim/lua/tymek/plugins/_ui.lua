return {
  -- vim.ui.input and vim.ui.select replacement
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      input = {
        relative = "cursor",
        insert_only = false,
      },
    },
  },

  -- color highlighting and format conversion
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    keys = {
      { "<Leader>c", "<Cmd>CccConvert<CR>", desc = "Convert color format (via ccc.nvim)" },
    },
    opts = {
      highlighter = {
        auto_enable = true,
      },
    },
  },
}
