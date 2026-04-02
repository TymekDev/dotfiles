vim.g.mapleader = " "

vim.api.nvim_cmd({
  cmd = "packadd",
  args = { "cfilter" },
}, {})
