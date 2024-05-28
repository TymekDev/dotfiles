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
}
