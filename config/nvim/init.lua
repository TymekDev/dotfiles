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

require("tymek.mappings").setup()
require("tymek.lsp").setup()
require("tymek.theme").update()
