local M = {}

local function setup(on_attach)
  local diag = require("null-ls").builtins.diagnostics
  local fmt = require("null-ls").builtins.formatting

  require("null-ls").setup({
    on_attach = on_attach,
    sources = {
      require("null-ls").builtins.code_actions.eslint,
      diag.eslint,
      diag.tsc,
      fmt.gofmt,
      fmt.goimports,
      fmt.prettier,
      fmt.stylelint,
    },
  })
end

M.setup = setup

return M
