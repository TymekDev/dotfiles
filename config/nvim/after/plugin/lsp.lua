vim.lsp.enable({
  "air",
  "astro",
  "cssls",
  "emmet_language_server",
  "gopls",
  "golangci_lint_ls",
  "html",
  "htmx",
  "jsonls",
  "lua_ls",
  "nixd",
  "r_language_server",
  "tailwindcss",
  "taplo",
  "templ",
  "ts_ls",
  "yamlls",
  "unocss",
})

vim.lsp.inlay_hint.enable()

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})
