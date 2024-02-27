-- FIXME: how to *not* use vim.cmd here?
vim.cmd [[let r_indent_align_args=0]]
vim.opt_local.textwidth = 100

vim.keymap.set("n", "<Leader>bi", require("tymek.r").put_missing_box_imports, { buffer = 0 })
