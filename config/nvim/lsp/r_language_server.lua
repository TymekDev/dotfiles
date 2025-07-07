---@type vim.lsp.Config
return {
  cmd = {
    "/usr/bin/env",
    "R",
    "--slave",
    "-e",
    [[options(
  languageserver.formatting_style = function(options) {
    styler::tidyverse_style(math_token_spacing = NULL)
  }
)

languageserver::run()
]],
  },
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function(opts)
        if vim.g.disable_autoformat or vim.b[opts.buf].disable_autoformat then
          return
        end

        vim.lsp.buf.format({
          filter = function(client)
            if vim.g.use_air then
              return client.name == "air"
            end
            return client.name == "r_language_server"
          end,
        })
      end,
    })
  end,
}
