vim.g.mapleader = " "
require("tymek.lazy").setup()

vim.api.nvim_cmd({
  cmd = "packadd",
  args = { "cfilter" },
}, {})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

require("tymek.theme").update()
