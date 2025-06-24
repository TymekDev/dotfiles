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

-- LSP & Diagnostic
vim.keymap.set("i", "<M-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "gK", vim.diagnostic.open_float)
vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "gt", "<Cmd>Telescope lsp_type_definitions<CR>")

vim.keymap.set("n", "gqd", vim.diagnostic.setqflist) -- [d]iagnostics
vim.keymap.set("n", "gqi", vim.lsp.buf.implementation) -- [i]mplementation
vim.keymap.set("n", "gqr", vim.lsp.buf.references) -- [r]eferences
vim.keymap.set("n", "gqs", vim.lsp.buf.document_symbol) -- [s]ybmol

vim.keymap.set("n", "<Leader>D", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.keymap.set("n", "[D", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = "ERROR" })
end)
vim.keymap.set("n", "]D", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = "ERROR" })
end)

-- Others
vim.keymap.set("n", "<Leader>z", "1z=")
