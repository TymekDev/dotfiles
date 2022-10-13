-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap
local xnoremap = require("tymek.keymap").xnoremap


-- Movements
nnoremap("<Leader>h", "<C-w>h")
nnoremap("<Leader>j", "<C-w>j")
nnoremap("<Leader>k", "<C-w>k")
nnoremap("<Leader>l", "<C-w>l")

nnoremap("<Leader><C-h>", { cmd = "tabprevious" })
nnoremap("<Leader><C-l>", { cmd = "tabnext" })

nnoremap("<C-h>", { cmd = "colder" })
nnoremap("<C-j>", { cmd = "cnext", count = true })
nnoremap("<C-k>", { cmd = "cprev", count = true })
nnoremap("<C-l>", { cmd = "cnewer" })

nnoremap("g;", require("harpoon.mark").add_file)
nnoremap("gh", function() require("harpoon.ui").nav_file(1) end)
nnoremap("gj", function() require("harpoon.ui").nav_file(2) end)
nnoremap("gk", function() require("harpoon.ui").nav_file(3) end)
nnoremap("gl", function() require("harpoon.ui").nav_file(4) end)


-- Registers
xnoremap("<Leader>p", '"_dP') -- don't overwrite paste register
nnoremap("<Leader>y", '"+y') -- copy to system register
xnoremap("<Leader>y", '"+y')


-- Opens a new buffer
nnoremap("<Leader><C-h>", require("harpoon.ui").toggle_quick_menu)
nnoremap("<Leader><C-e>", { cmd = "Ex" })
nnoremap("<Leader><C-g>", { cmd = "Git" })


-- Other
nnoremap("<Leader>Q", { cmd = "QuickScopeToggle" })
nnoremap("<Leader>W", { cmd = "WiderActiveBufToggle" })
nnoremap("<Leader>T", { cmd = "Twilight" })

nnoremap("gf", { cmd = "edit", args = { "%:p:h/<cfile>" }, magic = { file = true } })
