---@module "lazy"
---@type LazySpec
return {
  "tris203/precognition.nvim",
  event = "VeryLazy",
  ---@module "precognition"
  ---@type Precognition.PartialConfig
  opts = {
    showBlankVirtLine = false,
  },
}
