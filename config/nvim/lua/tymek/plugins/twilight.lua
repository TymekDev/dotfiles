---@module "lazy"
---@type LazySpec
return {
  "folke/twilight.nvim",
  cmd = "Twilight",
  keys = {
    {
      "<Leader>T",
      "<Cmd>Twilight<CR>",
      desc = "Toggle the twilight mode (via twilight.nvim)",
    },
  },
  ---@module "twilight"
  ---@type TwilightOptions
  opts = {},
}
