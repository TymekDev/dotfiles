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


require("tymek.lsp.cmp")
require("tymek.lsp.lspconfig").setup(on_attach)
require("tymek.lsp.null-ls").setup(on_attach)
