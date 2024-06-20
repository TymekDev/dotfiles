return {
  "folke/todo-comments.nvim", -- TODO: review config
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
    keywords = {
      EPIC = {
        color = "#ff9e64",
      },
      FEAT = {
        color = "#bb9af7",
      },
    },
  },
}
