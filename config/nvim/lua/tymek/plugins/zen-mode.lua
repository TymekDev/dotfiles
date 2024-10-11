---@module "lazy"
---@type LazySpec
return {
  "folke/zen-mode.nvim",
  cmd = "Twilight",
  keys = {
    {
      "<Leader>Z",
      "<Cmd>ZenMode<CR>",
      desc = "Toggle the zen mode (via twilight.nvim)",
    },
  },
  ---@module "zen-mode"
  ---@type ZenOptions
  opts = {},
}
