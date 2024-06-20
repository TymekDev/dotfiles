return {
  "nvim-telescope/telescope.nvim",
  lazy = false, -- TODO: remove this once I move all telescope mappings to 'keys'
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<Leader>ff",
      "<Cmd>Telescope resume<CR>",
      desc = "Open and restore the previously viewed picker (via telescope.nvim)",
    },
  },
  config = true,
}
