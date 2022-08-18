local nnoremap = require("tymek.keymap").nnoremap

nnoremap("gh", "<C-w>h")
nnoremap("gj", "<C-w>j")
nnoremap("gk", "<C-w>k")
nnoremap("gl", "<C-w>l")

nnoremap("<C-h>", "tabprevious", { cmd = true })
nnoremap("<C-j>", "cnext", { cmd = true })
nnoremap("<C-k>", "cprev", { cmd = true })
nnoremap("<C-l>", "tabnext", { cmd = true })
