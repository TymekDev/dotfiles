local function lsp_on_attach()
  if vim.bo[vim.api.nvim_get_current_buf()].filetype == "r" then
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
  end

  vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
end

---@module "lazy"
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  opts = function()
    return {
      servers = {
        air = {},

        astro = {},

        cssls = {},

        emmet_language_server = {},

        gopls = {
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
        },

        golangci_lint_ls = {},

        html = {},

        jsonls = {
          settings = {
            json = {
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
  }
)

languageserver::run()
]],
          },
        },

        tailwindcss = {},

        ts_ls = {
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

        unocss = {},
      },
    }
  end,
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      config.on_attach = lsp_on_attach
      lspconfig[server].setup(config)
    end
  end,
}
