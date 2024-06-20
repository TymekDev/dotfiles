return {
  "lewis6991/gitsigns.nvim", -- TODO: review config
  event = "VeryLazy",
  keys = {
    { "[g", "<Cmd>Gitsigns prev_hunk<CR>", desc = "Jump to the previous git hunk (via gitsigns.nvim)" },
    { "]g", "<Cmd>Gitsigns next_hunk<CR>", desc = "Jump to the next git hunk (via gitsigns.nvim)" },
  },
  config = true,
}
