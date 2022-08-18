local nnoremap = require("tymek.keymap").nnoremap

local function on_attach(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
  -- TODO: explore what other options `vim.lsp.` offers
  nnoremap("K", vim.lsp.buf.hover)
  nnoremap("gd", vim.lsp.buf.definition)
  nnoremap("gt", vim.lsp.buf.type_definition)
  nnoremap("gi", vim.lsp.buf.implementation)
  nnoremap("<Leader>ca", vim.lsp.buf.code_action)
  -- TODO: explore what other options `vim.diagnostic.` offers
  nnoremap("<Leader>dk", vim.diagnostic.goto_prev)
  nnoremap("<Leader>dj", vim.diagnostic.goto_next)
  nnoremap("<Leader>q", vim.diagnostic.setqflist)
  -- TODO: add rename
end


require("tymek.lsp.cmp")
require("tymek.lsp.lspconfig").setup(on_attach)
require("tymek.lsp.null-ls").setup(on_attach)
