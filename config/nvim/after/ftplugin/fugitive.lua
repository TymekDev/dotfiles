local function nnoremap_cmd(lhs, cmd)
  require("tymek.keymap").nnoremap(lhs, function() vim.cmd(cmd) end)
end

nnoremap_cmd("<Leader>gf", "Git fetch")
nnoremap_cmd("<Leader>gl", "Git pull")
nnoremap_cmd("<Leader>gp", "Git push")
