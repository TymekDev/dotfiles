-- lazy.nvim bootstrap start
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- lazy.nvim bootstrap end


local function lsp_on_attach(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end

  require("lsp-inlayhints").on_attach(client, vim.api.nvim_get_current_buf())
end

local opts = {
  install = {
    colorscheme = { "tokyonight" },
  },
}

local plugins = {
  {
    "folke/tokyonight.nvim",
    priority = 99,
    config = function()
      require("tokyonight").setup({
        lualine_bold = true,
        on_highlights = function(hl, c)
          hl.QuickScopePrimary = { fg = c.orange }
          hl.QuickScopeSecondary = {}
        end,
      })

      vim.api.nvim_cmd({ cmd = "colorscheme", args = { "tokyonight" } }, {})
    end,
  },
  {
    "nvim-lualine/lualine.nvim", -- TODO: review config
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim", -- TODO: review config
    dependencies = { "nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  },
  {
    "folke/todo-comments.nvim", -- TODO: review config
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = false,
      })
    end,
  },
  {
    -- TODO: add mappings (stage_hunk, next_hunk, prev_hunk)
    "lewis6991/gitsigns.nvim", -- TODO: review config
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
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
    config = function()
      require("nvim-treesitter.configs").setup({
        context = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        playground = { enable = true },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- See: https://github.com/nvim-telescope/telescope.nvim/issues/559
      local function wrap(action)
        return function(prompt_bufnr)
          vim.cmd.stopinsert()
          vim.schedule(function() action(prompt_bufnr) end)
        end
      end

      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = wrap(actions.select_default),
              ["<C-x>"] = wrap(actions.select_horizontal),
              ["<C-v>"] = wrap(actions.select_vertical),
              ["<C-t>"] = wrap(actions.select_tab),
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "unblevable/quick-scope",
    config = function()
      vim.g.qs_hi_priority = 20
      vim.g.qs_second_highlight = 0
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        fast_wrap = {},
      })
    end,
  },
  {
    "numToStr/Comment.nvim", -- TODO: review config
    config = function()
      require("Comment").setup()
    end,
  },
  "junegunn/vim-easy-align", -- TODO: review config
  "tpope/vim-fugitive",
  {
    "junegunn/gv.vim",
    dependencies = { "tpope/vim-fugitive" },
  },
  {
    "TymekDev/repos.nvim",
    config = function()
      require("repos").setup({
        callbacks = {
          ["sso"] = function(root)
            vim.opt.makeprg = "make -C " .. root
            vim.opt.shellpipe = "2>/dev/null | sed 's#^[^[:blank:]]#" .. root .. "/src/&#' | tee"
            vim.api.nvim_create_autocmd("FileType", {
              pattern = { "go", "markdown" },
              callback = function()
                vim.opt_local.textwidth = 0
              end,
            })

            vim.keymap.set({ "n", "x" }, "<Leader>go", function()
              require("tymek.git").open({ "", "labs", "master" })
            end)
          end,
        },
      })
    end,
  },
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-rsi",
  "tpope/vim-eunuch",
  "tpope/vim-abolish",
  {
    "folke/neodev.nvim",
    priority = 90, -- NOTE: has to be set up before nvim-lspconfig
    config = function()
      require("neodev").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    priority = 89, -- NOTE: has to be set up before mason-lspconfig.nvim
    config = function()
      require("mason").setup()
    end,
  },
  {
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
    "jay-babu/mason-null-ls.nvim",
    priority = 87, -- NOTE: has to be set up before null-ls.nvim
    dependencies = { "jose-elias-alvarez/null-ls.nvim", "williamboman/mason.nvim" },
    config = function()
      require("mason-null-ls").setup({
        automatic_installation = true,
        ensure_installed = { "gofumpt" },
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
            runtime = {
              version = "LuaJIT",
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

      require("lspconfig").rust_analyzer.setup(config())

      require("lspconfig").tailwindcss.setup(config({
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "classList", "class:list", "ngClass" },
          },
        },
      }))

      require("lspconfig").tsserver.setup(config({
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
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
    "jose-elias-alvarez/null-ls.nvim", -- TODO: review config
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("null-ls").setup({
        on_attach = lsp_on_attach,
        sources = {
          -- TODO: browse through linters, formatters etc.
          -- TODO: add linters!
          require("null-ls").builtins.formatting.goimports,
          require("null-ls").builtins.formatting.prettierd.with({
            extra_filetypes = { "astro" },
            disabled_filetypes = { "markdown", "yaml" },
          }),
          -- require("null-ls").builtins.diagnostics.checkmake,
          -- require("null-ls").builtins.diagnostics.commitlint,
          -- require("null-ls").builtins.diagnostics.eslint_d, -- TODO: is this needed with LSP, prettier, etc.?
          -- require("null-ls").builtins.diagnostics.fish,
          require("null-ls").builtins.diagnostics.golangci_lint, -- FIXME: golangci-lint works only if go.mod is in repository's root
          -- require("null-ls").builtins.diagnostics.luacheck,
          -- require("null-ls").builtins.diagnostics.shellcheck,
          -- require("null-ls").builtins.diagnostics.tsc,
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "hrsh7th/cmp-path",
    },
    config = function()
      require("cmp").setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = require("cmp").config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          {
            name = "path",
            option = { trailing_slash = true },
          },
        }),
      })
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("cmp").setup.cmdline(":", {
        sources = require("cmp").config.sources({
          { name = "cmdline" },
        })
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<M-j>", -- TODO: move this to mappings
          },
        },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "thehamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
    build = ":MasonInstall delve",
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        hint_enable = false,
      })
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("lsp-inlayhints").setup()
    end,
  },
}

require("lazy").setup(plugins, opts)
