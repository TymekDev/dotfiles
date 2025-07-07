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

---@param markers? string[]
local function root_dir_git_jj(markers)
  markers = markers or {}
  table.insert(markers, ".jj")
  table.insert(markers, ".git")
  return function()
    return vim.fs.root(0, markers)
  end
end

---@module "lazy"
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp", "b0o/schemastore.nvim" },
  opts = function()
    return {
      servers = {
        air = {
          root_dir = root_dir_git_jj({ "air.toml", ".air.toml" }),
        },

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
          root_dir = root_dir_git_jj({ ".Rprofile", "renv.lock" }),
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

        unocss = {
          root_dir = root_dir_git_jj({
            "unocss.config.js",
            "unocss.config.ts",
            "uno.config.js",
            "uno.config.ts",
            "slides.md",
          }),
        },
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
