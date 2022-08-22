local nnoremap = require("tymek.keymap").nnoremap

nnoremap("<Leader>h", "<C-w>h")
nnoremap("<Leader>j", "<C-w>j")
nnoremap("<Leader>k", "<C-w>k")
nnoremap("<Leader>l", "<C-w>l")

nnoremap("gh", function() print("<Leader>h") end)
nnoremap("gj", function() print("<Leader>j") end)
nnoremap("gk", function() print("<Leader>k") end)
nnoremap("gl", function() print("<Leader>l") end)

nnoremap("<C-h>", "tabprevious", { cmd = true })
nnoremap("<C-j>", "cnext", { cmd = true })
nnoremap("<C-k>", "cprev", { cmd = true })
nnoremap("<C-l>", "tabnext", { cmd = true })

nnoremap("<Leader><C-e>", "Ex", { cmd = true })
