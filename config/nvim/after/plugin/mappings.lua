-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap

nnoremap("<Leader>h", "<C-w>h")
nnoremap("<Leader>j", "<C-w>j")
nnoremap("<Leader>k", "<C-w>k")
nnoremap("<Leader>l", "<C-w>l")

nnoremap("<C-h>", "tabprevious", { cmd = true })
nnoremap("<C-j>", "cnext", { cmd = true })
nnoremap("<C-k>", "cprev", { cmd = true })
nnoremap("<C-l>", "tabnext", { cmd = true })

nnoremap("<Leader><C-e>", "Ex", { cmd = true })

nnoremap("<Leader>K", function() vim.fn.jobstart({ "xdg-open", vim.fn.expand("<cWORD>"):match("https?://.*[^) ]") }) end)

-- Plugins
nnoremap("<Leader>T", "Twilight", { cmd = true })
