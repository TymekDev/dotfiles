vim.lsp.enable({
  "air",
  "astro",
  "bashls",
  "cssls",
  "emmet_language_server",
  "fish_lsp",
  "golangci_lint_ls",
  "gopls",
  "html",
  "htmx",
  "jsonls",
  "lua_ls",
  "nixd",
  "pylsp",
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
