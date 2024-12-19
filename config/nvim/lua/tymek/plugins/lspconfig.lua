local function lsp_on_attach()
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

  vim.lsp.inlay_hint.enable(true, { bufnr = 0 })

  require("tymek.mappings").setup_lsp()
end

---@module "lazy"
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp", "b0o/schemastore.nvim" },
  opts = function()
    return {
      servers = {
        astro = {},

        cssls = {},

        emmet_language_server = {},

        gopls = {
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
        },

        golangci_lint_ls = {},

        html = {
          settings = {
            html = {
              format = {
                unformatted = { "dd" },
                wrapLineLength = 0,
              },
            },
          },
        },

        htmx = {},

        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              telemetry = {
                enable = false,
              },
            },
          },
        },

        r_language_server = {
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
        },

        rust_analyzer = {},

        tailwindcss = {},

        ts_ls = {
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
        },

        yamlls = {
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
        },
      },
    }
  end,
  config = function(_, opts)
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local lspconfig = require("lspconfig")
    for server, config in pairs(opts.servers) do
      config.capabilities = capabilities
      config.on_attach = lsp_on_attach
      lspconfig[server].setup(config)
    end
  end,
}
