return {
  {
    "tpope/vim-rsi",
    config = function()
      vim.keymap.del("i", "<C-X><C-A>")
    end,
  },
  "tpope/vim-eunuch",
  "tpope/vim-abolish",
}
