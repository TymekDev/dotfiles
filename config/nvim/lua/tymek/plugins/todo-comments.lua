---@module "lazy"
---@type LazySpec
return {
  "folke/todo-comments.nvim", -- TODO: review config
  enabled = false,
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@module "todo-comments"
  ---@type TodoConfig
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
