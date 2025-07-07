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

-- Tools
vim.keymap.set("n", "<C-y>", "<Cmd>YaziTmux<CR>")
vim.keymap.set("n", "<C-s>", "<Cmd>silent !tmux run-shell tmux-sessionizer<CR>")

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

-- Splits
vim.keymap.set("n", "gh", "<C-w>h")
vim.keymap.set("n", "gj", "<C-w>j")
vim.keymap.set("n", "gk", "<C-w>k")
vim.keymap.set("n", "gl", "<C-w>l")

-- Screen
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz") -- Half a screen up with center on cursor
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz") -- Half a screen down with center on cursor
vim.keymap.set({ "n", "v" }, "<C-b>", "<NOP>")

-- Search Results
vim.keymap.set({ "n", "v" }, "n", "nzzzv") -- Next search result, center on cursor, and open folds
vim.keymap.set({ "n", "v" }, "N", "Nzzzv") -- Previous search result, center on cursor, and open folds

-- Quickfix list
vim.keymap.set("n", "<C-h>", function() -- Previous quickfix list with opening if non-empty
  vim.cmd.colder({ count = vim.api.nvim_eval("v:count1") })
  vim.cmd.cwindow()
end)
vim.keymap.set("n", "<C-j>", function() -- Next quickfix entry with wrapping and opening if non-empty
  local ok, msg = pcall(vim.cmd.cnext, { count = vim.api.nvim_eval("v:count1") })
  if ok == false and msg == "Vim:E553: No more items" then
    vim.cmd.cfirst()
  end
  vim.cmd.cwindow()
end)
vim.keymap.set("n", "<C-k>", function() -- Previous quickfix entry with wrapping and opening if non-empty
  local ok, msg = pcall(vim.cmd.cprev, { count = vim.api.nvim_eval("v:count1") })
  if ok == false and msg == "Vim:E553: No more items" then
    vim.cmd.clast()
  end
  vim.cmd.cwindow()
end)
vim.keymap.set("n", "<C-l>", function() -- Next quickfix list with opening if non-empty
  vim.cmd.cnewer({ count = vim.api.nvim_eval("v:count1") })
  vim.cmd.cwindow()
end)

-- Registers
vim.keymap.set("v", "<Leader>p", '"_dP') -- Don't overwrite paste register
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y') -- Use system register
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+Y')

-- Others
vim.keymap.set("n", "<Leader>z", "1z=")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
