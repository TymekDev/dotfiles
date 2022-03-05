-- Setup LSP

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').gopls.setup{
  capabilities = capabilities,
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

-- CSS
require('lspconfig').stylelint_lsp.setup{
  capabilities = capabilities,
}

-- HTML
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').html.setup{
  capabilities = capabilities,
}


-- Setup nvim-cmp
vim.opt.completeopt={"menu", "menuone", "noselect"}

local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-j>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})
