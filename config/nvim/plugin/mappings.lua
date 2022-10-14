-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap
local xnoremap = require("tymek.keymap").xnoremap


-- Splits, tabs, and QuickFix list
nnoremap("<Leader>h", "<C-w>h")
nnoremap("<Leader>j", "<C-w>j")
nnoremap("<Leader>k", "<C-w>k")
nnoremap("<Leader>l", "<C-w>l")

nnoremap("<C-p>", { cmd = "tabprevious" })
nnoremap("<C-n>", { cmd = "tabnext" })

nnoremap("<C-h>", { cmd = "colder" })
nnoremap("<C-j>", { cmd = "cnext", count = true })
nnoremap("<C-k>", { cmd = "cprev", count = true })
nnoremap("<C-l>", { cmd = "cnewer" })


-- Special buffers
nnoremap("<Leader><C-e>", { cmd = "Ex" })
nnoremap("<Leader><C-g>", { cmd = "Git" })


-- Registers
xnoremap("<Leader>p", '"_dP') -- don't overwrite paste register
nnoremap("<Leader>y", '"+y') -- copy to system register
xnoremap("<Leader>y", '"+y')


-- Toggles
nnoremap("<Leader>Q", { cmd = "QuickScopeToggle" })
nnoremap("<Leader>W", { cmd = "WiderActiveBufToggle" })
nnoremap("<Leader>T", { cmd = "Twilight" })


-- Harpoon
nnoremap("<Leader>gg", require("harpoon.ui").toggle_quick_menu)
nnoremap("<Leader>g;", require("harpoon.mark").add_file)
nnoremap("<Leader>gh", function() require("harpoon.ui").nav_file(1) end)
nnoremap("<Leader>gj", function() require("harpoon.ui").nav_file(2) end)
nnoremap("<Leader>gk", function() require("harpoon.ui").nav_file(3) end)
nnoremap("<Leader>gl", function() require("harpoon.ui").nav_file(4) end)
