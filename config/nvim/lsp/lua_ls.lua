---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end,
}
