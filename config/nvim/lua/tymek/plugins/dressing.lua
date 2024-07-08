---@module "lazy"
---@type LazySpec
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    input = {
      relative = "cursor",
      insert_only = false,
    },
  },
}
