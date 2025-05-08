---@module "lazy"
---@type LazySpec
return {
  "voxelprismatic/rabbit.nvim",
  lazy = false,
  keys = {
    { "<Leader>r", "<Cmd>Rabbit trail<CR>", desc = "Browse previously visited buffers (via rabbit.nvim)" },
  },
  branch = "rewrite",
  ---@module "rabbit"
  ---@type Rabbit.Config
  opts = {
    keys = {
      switch = {},
    },
  },
}
