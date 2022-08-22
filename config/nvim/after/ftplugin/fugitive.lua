local nnoremap = require("tymek.keymap").nnoremap

nnoremap("<Leader>gf", "Git fetch", { cmd = true })
nnoremap("<Leader>gl", "Git pull", { cmd = true })
nnoremap("<Leader>gp", "Git push", { cmd = true })
