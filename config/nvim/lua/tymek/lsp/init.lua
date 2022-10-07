local function nnoremap(lhs, rhs)
  require("tymek.keymap").nnoremap(lhs, rhs, { buffer = 0 })
end

local function on_attach(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end

  nnoremap("K", vim.lsp.buf.hover)
  nnoremap("gd", vim.lsp.buf.definition)
  nnoremap("gt", vim.lsp.buf.type_definition)
  nnoremap("gr", vim.lsp.buf.rename)

  nnoremap("gqd", vim.diagnostic.setqflist)    -- [d]iagnostics
  nnoremap("gqi", vim.lsp.buf.implementation)  -- [i]mplementation
  nnoremap("gqr", vim.lsp.buf.references)      -- [r]eferences
  nnoremap("gqs", vim.lsp.buf.document_symbol) -- [s]ybmol
end

require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
require("tymek.lsp.cmp")
require("tymek.lsp.lspconfig").setup(on_attach)
require("tymek.lsp.null-ls").setup(on_attach)
