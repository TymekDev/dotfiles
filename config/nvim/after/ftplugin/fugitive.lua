local nnoremap = require("tymek.keymap").nnoremap

nnoremap("<Leader>gf", { cmd = "Git fetch" })
nnoremap("<Leader>gl", { cmd = "Git pull" })
nnoremap("<Leader>gp", { cmd = "Git push" })
