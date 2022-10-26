local M = {}

local function setup(on_attach)
  local prettier = require("null-ls").builtins.formatting.prettier
  prettier.filetypes = vim.tbl_filter(function(x) return x ~= "markdown" end, prettier.filetypes)

  require("null-ls").setup({
    on_attach = on_attach,
    sources = {
      require("null-ls").builtins.formatting.goimports,
      prettier,
    },
  })
end

M.setup = setup

return M
