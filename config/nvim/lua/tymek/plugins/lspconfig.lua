local function lsp_on_attach(client)
  if vim.bo[vim.api.nvim_get_current_buf()].filetype == "r" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function(opts)
        if vim.g.disable_autoformat or vim.b[opts.buf].disable_autoformat then
          return
        end
        vim.lsp.buf.format()
      end,
    })
  end

  require("lsp-inlayhints").on_attach(client, vim.api.nvim_get_current_buf())

  require("tymek.mappings").setup_lsp()
end

---@module "lazy"
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp", "b0o/schemastore.nvim" },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local function config(_config)
      return vim.tbl_deep_extend("force", { capabilities = capabilities, on_attach = lsp_on_attach }, _config or {})
    end

    require("lspconfig").astro.setup(config())

    require("lspconfig").cssls.setup(config())

    require("lspconfig").emmet_language_server.setup(config())

    require("lspconfig").gopls.setup(config({
      settings = {
        gopls = {
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
    }))

    require("lspconfig").golangci_lint_ls.setup(config())

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

    require("lspconfig").htmx.setup(config())

    require("lspconfig").jsonls.setup(config({
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }))

    require("lspconfig").lua_ls.setup(config({
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
    }))

    require("lspconfig").r_language_server.setup(config({
      cmd = {
        "/usr/bin/env",
        "R",
        "--slave",
        "-e",
        [[options(
  languageserver.formatting_style = function(options) {
    styler::tidyverse_style(math_token_spacing = NULL)
  },
  languageserver.server_capabilities = list(
    completionProvider = FALSE,
    completionItemResolve = FALSE
  )
)

languageserver::run()
]],
      },
    }))

    require("lspconfig").rust_analyzer.setup(config())

    require("lspconfig").tailwindcss.setup(config({
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "classList", "class:list", "ngClass" },
        },
      },
    }))

    require("lspconfig").ts_ls.setup(config({
      filetypes = { "typescript", "typescriptreact", "javascript" },
      settings = {
        typescript = {
          inlayHints = {
            -- includeInlayParameterNameHints = "all", -- I don't find these very useful
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    }))

    require("lspconfig").yamlls.setup(config({
      settings = {
        yaml = {
          schemas = {
            kubernetes = "*.k8s.yaml",
            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
          },
        },
        redhat = {
          telemetry = {
            enabled = false,
          },
        },
      },
    }))
  end,
}
