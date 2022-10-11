local nnoremap = require("tymek.keymap").nnoremap

nnoremap("<Leader>gf", { cmd = "Git", args = { "fetch" } })
nnoremap("<Leader>gl", { cmd = "Git", args = { "pull" } })
nnoremap("<Leader>gp", { cmd = "Git", args = { "push" } })

