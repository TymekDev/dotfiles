---@type vim.lsp.Config
return {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
