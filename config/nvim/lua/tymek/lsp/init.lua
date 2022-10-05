local function nnoremap(lhs, rhs)
  require("tymek.keymap").nnoremap(lhs, rhs, { buffer = 0 })
end

local function on_attach(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })
  end

  nnoremap("K", vim.lsp.buf.hover)
  nnoremap("gd", vim.lsp.buf.definition)
  nnoremap("gt", vim.lsp.buf.type_definition)
  nnoremap("gi", vim.lsp.buf.implementation)
  nnoremap("gr", vim.lsp.buf.references)
  nnoremap("<Leader>r", vim.lsp.buf.rename)
  nnoremap("<Leader>ca", vim.lsp.buf.code_action)

  nnoremap("gj", vim.diagnostic.goto_next)
  nnoremap("gk", vim.diagnostic.goto_prev)
  nnoremap("gq", vim.diagnostic.setqflist)
end

require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
require("tymek.lsp.cmp")
require("tymek.lsp.lspconfig").setup(on_attach)
require("tymek.lsp.null-ls").setup(on_attach)
