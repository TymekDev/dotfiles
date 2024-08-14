---@module "lazy"
---@type LazySpec
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      relative = "cursor",
      insert_only = false,
    },
  },
}
