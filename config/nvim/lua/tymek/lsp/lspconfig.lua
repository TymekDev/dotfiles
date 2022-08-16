local M = {}

local function setup(on_attach)
  local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local function config(_config)
    return vim.tbl_deep_extend("force", { capabilities = capabilities, on_attach = on_attach }, _config or {})
  end

  require("lspconfig").cssls.setup(config())

  require("lspconfig").eslint.setup(config({
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "vue" }
  }))

  require("lspconfig").gopls.setup(config())

  require("lspconfig").html.setup(config())

  require("lspconfig").r_language_server.setup(config())

  require("lspconfig").rust_analyzer.setup(config())

  require("lspconfig").tsserver.setup(config({
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
  }))
end

M.setup = setup

return M
