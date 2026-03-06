---@type vim.lsp.Config
return {
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function(opts)
        if vim.g.disable_autoformat or vim.b[opts.buf].disable_autoformat then
          return
        end

        vim.lsp.buf.format({
          filter = function(client)
            return client.name == "air"
          end,
        })
      end,
    })
  end,
}
