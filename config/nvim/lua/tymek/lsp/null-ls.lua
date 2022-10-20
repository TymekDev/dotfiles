local M = {}

local function setup(on_attach)
  local prettier = require("null-ls").builtins.formatting.prettier
  prettier.filetypes = vim.tbl_filter(function(x) return x ~= "markdown" end, prettier.filetypes)

  require("null-ls").setup({
    on_attach = on_attach,
    sources = {
      require("null-ls").builtins.code_actions.eslint,
      require("null-ls").builtins.diagnostics.eslint,
      require("null-ls").builtins.diagnostics.tsc,
      require("null-ls").builtins.formatting.goimports,
      require("null-ls").builtins.formatting.stylelint,
      prettier,
    },
  })
end

M.setup = setup

return M
