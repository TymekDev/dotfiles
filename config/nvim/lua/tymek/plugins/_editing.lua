return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      move_cursor = false,
    },
  },

  {
    "folke/ts-comments.nvim",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
    event = "VeryLazy",
    config = true,
  },
}
