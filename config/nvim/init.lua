require("tymek.plugins")

vim.api.nvim_cmd({
  cmd = "packadd",
  args = { "cfilter" },
}, {})
