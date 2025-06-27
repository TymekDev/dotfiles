---@module "lazy"
---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  keys = {
    {
      "<C-y>",
      function()
        vim.system({ "tmux", "new-window", "yazi", vim.fn.expand("%:p:h") })
      end,
    },
  },
  cmd = "Yazi",
  ---@module "yazi"
  ---@type YaziConfig | {}
  opts = {},
}
