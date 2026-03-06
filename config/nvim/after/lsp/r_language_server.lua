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
}
