return {
  "lewis6991/gitsigns.nvim", -- TODO: review config
  event = "VeryLazy",
  opts = {
    on_attach = function()
      vim.keymap.set(
        { "n", "v" },
        "[g",
        "<Cmd>Gitsigns prev_hunk<CR>",
        { desc = "Jump to the previous git hunk (via gitsigns.nvim)" }
      )
      vim.keymap.set(
        { "n", "v" },
        "]g",
        "<Cmd>Gitsigns next_hunk<CR>",
        { desc = "Jump to the next git hunk (via gitsigns.nvim)" }
      )
    end,
  },
}
