vim.opt_local.spell = true

vim.api.nvim_set_hl(0, "@neorg.markup.italic.norg", { italic = true })

vim.keymap.set("n", "<Leader>C", "<Cmd>Neorg toggle-concealer<CR>", { buffer = 0 })
