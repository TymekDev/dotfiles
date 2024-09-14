vim.opt_local.conceallevel = 2
vim.opt_local.spell = true
vim.opt_local.textwidth = 80

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Update Neorg metadata before saving",
  buffer = 0,
  command = "Neorg update-metadata",
})
