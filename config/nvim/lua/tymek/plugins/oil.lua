return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Open the parent directory (via oil.nvim)" },
  },
  ---@module "oil"
  ---@type oil.setupOpts
  opts = {
    use_default_keymaps = false,
    keymaps = {
      ["<CR>"] = "actions.select",
    },
    view_options = {
      show_hidden = true,
    },
  },
}
