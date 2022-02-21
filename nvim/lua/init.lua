require('lspconfig').gopls.setup{
  on_attach = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set('n', '<Leader>k', vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set('n', '<Leader>j', vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, {buffer=0})
  end,
}
