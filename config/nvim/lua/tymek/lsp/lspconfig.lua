local M = {}

local function setup(on_attach)
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local function config(_config)
    return vim.tbl_deep_extend("force", { capabilities = capabilities, on_attach = on_attach }, _config or {})
  end

  require("lspconfig").astro.setup(config())

  require("lspconfig").cssls.setup(config())

  require("lspconfig").eslint.setup(config())

  require("lspconfig").gopls.setup(config({
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  }))

  require("lspconfig").html.setup(config({
    settings = {
      html = {
        format = {
          unformatted = { "dd" },
          wrapLineLength = 0,
        },
      },
    },
  }))

  require("lspconfig").rust_analyzer.setup(config())

  require("lspconfig").lua_ls.setup(config({
    settings = {
      Lua = {
        runtime = { version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }))

  require("lspconfig").tailwindcss.setup(config({
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "classList", "class:list", "ngClass" },
      },
    },
  }))

  require("lspconfig").tsserver.setup(config({
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  }))
end

M.setup = setup

return M
