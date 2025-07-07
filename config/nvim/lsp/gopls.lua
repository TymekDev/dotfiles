---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      buildFlags = { "-tags", "tests" },
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        -- parameterNames = true, -- I don't find these very useful
        rangeVariableTypes = true,
      },
    },
  },
}
