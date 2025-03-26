---@module "lazy"
---@type LazySpec
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  ---@module "noice"
  ---@type NoiceConfig
  opts = {
    cmdline = {
      opts = {
        position = { row = 0, col = -2 }, -- -2 makes the popup offset by its border, so the cursor doesn't move
        relative = "cursor",
      },
    },
    routes = {
      { filter = { event = "msg_show", find = "yanked" } },
      { filter = { event = "msg_show", find = "%d fewer lines" } },
      { filter = { event = "msg_show", find = "%d more lines" } },
    },
  },
}
