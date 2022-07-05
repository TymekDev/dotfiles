local lspconfig = require("lspconfig")
local null_ls = require("null-ls")


-- Helpers
local function on_attach()
  local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
    -- TODO: explore what other options `vim.lsp.` offers
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {buffer=0})
    -- TODO: explore what other options `vim.diagnostic.` offers
    vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n", "<Leader>q", vim.diagnostic.setqflist, {buffer=0})
    -- TODO: add rename
  end
end

local function config(_config)
  return vim.tbl_deep_extend("force", {capabilities = capabilities, on_attach = on_attach()}, _config or {})
end


-- LSP
lspconfig.eslint.setup(config({ filetypes = { "javascript", "javascriptreact", "javascript.jsx", "vue" } }))
lspconfig.gopls.setup(config())
lspconfig.html.setup(config())
lspconfig.r_language_server.setup(config())
lspconfig.rust_analyzer.setup(config())
lspconfig.tsserver.setup(config({ filetypes = { "typescript", "typescriptreact", "typescript.tsx" } }))


-- null-ls
local nls_diagnostics = null_ls.builtins.diagnostics
local nls_formatting = null_ls.builtins.formatting
null_ls.setup({
  on_attach = on_attach(),
  sources = {
    null_ls.builtins.code_actions.eslint,
    nls_diagnostics.eslint,
    nls_diagnostics.tsc,
    nls_formatting.gofmt,
    nls_formatting.goimports,
    nls_formatting.prettier,
    nls_formatting.stylelint,
  },
})


-- tabnine
require("cmp_tabnine.config"):setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
})