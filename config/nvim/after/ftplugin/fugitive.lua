local nnoremap = function(lhs, rhs)
  require("tymek.keymap").nnoremap(lhs, rhs, { buffer = 0 })
end

nnoremap("<Leader>gf", { cmd = "Git", args = { "fetch" } })
nnoremap("<Leader>gl", { cmd = "Git", args = { "pull" } })
nnoremap("<Leader>gp", { cmd = "Git", args = { "push" } })
nnoremap("<Leader>gpf", function() vim.notify(vim.fn.system({ "git", "push", "--force-with-lease" })) end)
