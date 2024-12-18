vim.g.mapleader = " "
require("tymek.lazy").setup()

vim.api.nvim_cmd({
  cmd = "packadd",
  args = { "cfilter" },
}, {})

vim.filetype.add({
  extension = {
    d2 = "d2",
  },
})

require("tymek.mappings").setup()
