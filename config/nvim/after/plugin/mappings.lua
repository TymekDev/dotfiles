-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap
local xnoremap = require("tymek.keymap").xnoremap


-- Movements
nnoremap("<Leader>h", "<C-w>h")
nnoremap("<Leader>j", "<C-w>j")
nnoremap("<Leader>k", "<C-w>k")
nnoremap("<Leader>l", "<C-w>l")

nnoremap("<C-h>", "tabprevious", { cmd = true })
nnoremap("<C-j>", "cnext", { cmd = true, count = true })
nnoremap("<C-k>", "cprev", { cmd = true, count = true })
nnoremap("<C-l>", "tabnext", { cmd = true })


-- Registers
xnoremap("<Leader>p", '"_dP') -- don't overwrite paste register
nnoremap("<Leader>y", '"+y') -- copy to system register
xnoremap("<Leader>y", '"+y')


-- Opens a new buffer
nnoremap("<Leader><C-e>", "Ex", { cmd = true })
nnoremap("<Leader><C-g>", "Git", { cmd = true })


-- Other
nnoremap("<Leader>Q", "QuickScopeToggle", { cmd = true })
nnoremap("<Leader>T", "Twilight", { cmd = true })
nnoremap("<Leader>K", function() vim.fn.jobstart({ "xdg-open", vim.fn.expand("<cWORD>"):match("https?://.*[^) ]") }) end)

nnoremap("gf", function()
  vim.cmd({
    cmd = "edit",
    args = { vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("<cfile>") }
  })
end)
