local function nnoremap(lhs, rhs)
  require("tymek.keymap").nnoremap(lhs, rhs, { buffer = 0 })
end

return function(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end

  -- TODO: move these to mappings, possibly make them nop
  nnoremap("K", vim.lsp.buf.hover)
  nnoremap("gd", vim.lsp.buf.definition)
  nnoremap("gt", vim.lsp.buf.type_definition)
  nnoremap("gr", vim.lsp.buf.rename)
  nnoremap("gK", vim.diagnostic.open_float)
  nnoremap("gca", vim.lsp.buf.code_action)

  nnoremap("gqd", vim.diagnostic.setqflist)    -- [d]iagnostics
  nnoremap("gqi", vim.lsp.buf.implementation)  -- [i]mplementation
  nnoremap("gqr", vim.lsp.buf.references)      -- [r]eferences
  nnoremap("gqs", vim.lsp.buf.document_symbol) -- [s]ybmol

  -- gn/gp + gk vs gj/gk + gK
  vim.keymap.set({ "n", "x" }, "gj", vim.diagnostic.goto_next, { buffer = true })
  vim.keymap.set({ "n", "x" }, "gk", vim.diagnostic.goto_prev, { buffer = true })

  vim.keymap.set("n", "<Leader>gd", function()
    vim.cmd.vsplit()
    vim.lsp.buf.definition()
  end, { buffer = true })
  vim.keymap.set("n", "<Leader>gt", function()
    vim.cmd.vsplit()
    vim.lsp.buf.type_definition()
  end, { buffer = true })

  nnoremap("<Leader>fd", require("telescope.builtin").diagnostics)
  nnoremap("<Leader>fi", require("telescope.builtin").lsp_implementations)
  nnoremap("<Leader>fr", require("telescope.builtin").lsp_references)
  nnoremap("<Leader>fs", require("telescope.builtin").lsp_document_symbols)
  nnoremap("<Leader>fw", require("telescope.builtin").lsp_dynamic_workspace_symbols)
end
