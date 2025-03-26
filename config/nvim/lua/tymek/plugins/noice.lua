---@module "lazy"
---@type LazySpec
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  ---@module "noice"
  ---@type NoiceConfig
  opts = {
    cmdline = {
      opts = {
        position = { row = 0, col = -2 }, -- -2 makes the popup offset by its border, so the cursor doesn't move
        relative = "cursor",
      },
    },
    views = {
      mini = {
        relative = "cursor",
        position = { row = 0, col = 0 },
      },
    },
  },
}
