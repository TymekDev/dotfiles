return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Open parent directory (via oil.nvim)" }
  },
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
