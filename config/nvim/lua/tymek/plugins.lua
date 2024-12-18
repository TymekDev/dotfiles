-- FIXME: :Move %<tab> doesn't remove % after expansion - probably wildchar issues
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

return {
  {
    "folke/tokyonight.nvim",
    priority = 99,
    config = function()
      require("tokyonight").setup({
        lualine_bold = true,
        on_highlights = function(hl, _)
          hl["@r.reactive.call"] = { link = "Special" }
          hl["@r.box.unused.import"] = { link = "Error" }
          hl.NvimSurroundHighlight = { link = "IncSearch" }
        end,
      })

      require("tymek.theme").update()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      parser_configs.scss.install_info.url = "https://github.com/TymekDev/tree-sitter-scss"
      parser_configs.scss.install_info.revision = "master"

      require("nvim-treesitter.configs").setup({
        -- Make sure the comment parser gets never installed. See:
        --  - https://github.com/folke/ts-comments.nvim/issues/55#issuecomment-2363200467
        --  - https://github.com/folke/ts-comments.nvim/discussions/57
        ignore_install = { "comment" },
        auto_install = true,
        highlight = { enable = true },
      })

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      max_lines = 5,
    },
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        fast_wrap = {},
      })
    end,
  },
  "junegunn/vim-easy-align", -- TODO: review config
  {
    "tpope/vim-rsi",
    config = function()
      vim.keymap.del("i", "<C-X><C-A>")
    end,
  },
  "tpope/vim-eunuch",
  "tpope/vim-abolish",
  {
    "williamboman/mason.nvim",
    priority = 89, -- NOTE: has to be set up before mason-lspconfig.nvim
    config = true,
  },
  {
    -- TODO: remove this plugin and move binaries installation to dotfiles setup
    "williamboman/mason-lspconfig.nvim",
    priority = 88, -- NOTE: has to be set up before nvim-lspconfig
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    priority = 78,
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
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
      require("dap").listeners.after.event_initialized["dapui_config"] = require("dapui").open
      require("dap").listeners.before.event_terminated["dapui_config"] = require("dapui").close
      require("dap").listeners.before.event_exited["dapui_config"] = require("dapui").close
    end,
  },
  {
    "thehamsta/nvim-dap-virtual-text",
    enabled = false,
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "leoluz/nvim-dap-go",
    enabled = false,
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
    build = ":MasonInstall delve",
    config = true,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        hint_enable = false,
        toggle_key = "<M-k>",
        toggle_key_flip_floatwin_setting = true,
      })
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = true,
  },
}
