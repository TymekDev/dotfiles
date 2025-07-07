vim.g.mapleader = " "
require("tymek.lazy").setup()

vim.api.nvim_cmd({
  cmd = "packadd",
  args = { "cfilter" },
}, {})

require("tymek.theme").update()
