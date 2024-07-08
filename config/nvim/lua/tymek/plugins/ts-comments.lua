---@module "lazy"
---@type LazySpec
return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  ---@module "ts-comments"
  ---@type TSCommentsOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = {},
}
