-- Previous and next pairs
vim.keymap.set("n", "[t", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", "]t", "<Cmd>tabnext<CR>")

-- Toggles
vim.keymap.set("n", "<Leader>W", "<Cmd>WiderActiveBufToggle<CR>")
vim.keymap.set("n", "<Leader>R", function()
  vim.o.relativenumber = not vim.o.relativenumber
end)
vim.keymap.set("n", "<Leader>S", function()
  vim.opt_local.spell = not vim.api.nvim_get_option_value("spell", { scope = "local" })
end)

-- LSP
vim.keymap.set("i", "<M-k>", vim.lsp.buf.signature_help)

-- Others
vim.keymap.set("n", "<Leader>z", "1z=")
vim.keymap.set("n", "q:", "<Nop>")
