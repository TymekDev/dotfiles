-- FIXME: how to *not* use vim.cmd here?
vim.cmd([[let r_indent_align_args=0]])
vim.opt_local.textwidth = 100

vim.keymap.set("n", "<Leader>bi", require("tymek.r.box_imports").put_missing, { buffer = 0 })
require("tymek.treesitter").setup_highlight(0, require("tymek.r.reactives").highlight_calls)
require("tymek.treesitter").setup_highlight(0, require("tymek.r.box_unused_imports").highlight_unused_imports)
