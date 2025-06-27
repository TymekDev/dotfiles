---@module "lazy"
---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  cmd = "Yazi",
  ---@module "yazi"
  ---@type YaziConfig | {}
  opts = {},
}
