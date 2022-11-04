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
  nnoremap("gk", vim.diagnostic.open_float)

  nnoremap("gqd", vim.diagnostic.setqflist) -- [d]iagnostics
  nnoremap("gqi", vim.lsp.buf.implementation) -- [i]mplementation
  nnoremap("gqr", vim.lsp.buf.references) -- [r]eferences
  nnoremap("gqs", vim.lsp.buf.document_symbol) -- [s]ybmol

  nnoremap("<Leader>fd", require("telescope.builtin").diagnostics)
  nnoremap("<Leader>fi", require("telescope.builtin").lsp_implementations)
  nnoremap("<Leader>fr", require("telescope.builtin").lsp_references)
  nnoremap("<Leader>fs", require("telescope.builtin").lsp_document_symbols)
  nnoremap("<Leader>fw", require("telescope.builtin").lsp_dynamic_workspace_symbols)
end

require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
require("tymek.lsp.cmp")
require("tymek.lsp.lspconfig").setup(on_attach)
require("tymek.lsp.null-ls").setup(on_attach)
