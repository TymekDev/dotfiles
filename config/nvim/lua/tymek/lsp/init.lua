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
  nnoremap("gi", vim.lsp.buf.implementation)
  nnoremap("<Leader>r", vim.lsp.buf.rename)
  nnoremap("<Leader>ca", vim.lsp.buf.code_action)

  nnoremap("<Leader>dk", vim.diagnostic.goto_prev)
  nnoremap("<Leader>dj", vim.diagnostic.goto_next)
  nnoremap("<Leader>q", vim.diagnostic.setqflist)
end


require("tymek.lsp.cmp")
require("tymek.lsp.lspconfig").setup(on_attach)
require("tymek.lsp.null-ls").setup(on_attach)
