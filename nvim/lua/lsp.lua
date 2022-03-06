local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local addFormatAutocmd = function()
  vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
end


-- CSS
require('lspconfig').stylelint_lsp.setup{
  capabilities = capabilities,
  on_attach = addFormatAutocmd,
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
    },
  },
}


-- Golang
require('lspconfig').gopls.setup{
  capabilities = capabilities,
  on_attach = function()
    addFormatAutocmd()
    -- TODO: explore what other options `vim.lsp.` offers
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {buffer=0})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer=0})
    -- TODO: explore what other options `vim.diagnostic.` offers
    vim.keymap.set('n', '<Leader>k', vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set('n', '<Leader>j', vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, {buffer=0})
    -- TODO: add rename
  end,
}


-- HTML
-- NOTE: I am not sure if this should be last as it alters capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').html.setup{
  capabilities = capabilities,
  on_attach = addFormatAutocmd,
}
