local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"


  -- LSP and stuff
  use {
    {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    config = function()
      require("cmp_tabnine.config").setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
      })
    end,
  }


  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    "rrethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
  }

  -- Git stuff
  use "junegunn/gv.vim"
  use "tpope/vim-fugitive"

  use {
    "airblade/vim-gitgutter",
    setup = function()
      vim.g.gitgutter_map_keys = 0
    end,
  }

  -- Movements, editing, and navigation
  use "junegunn/vim-easy-align"
  use "tpope/vim-abolish"
  use "tpope/vim-repeat"
  use "tpope/vim-rsi"
  use "tpope/vim-surround"

  use {
    "ThePrimeagen/git-worktree.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "ThePrimeagen/harpoon",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  }

  use {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "unblevable/quick-scope",
    config = function()
      vim.g.qs_hi_priority = 20
      vim.g.qs_second_highlight = 0
    end,
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        fast_wrap = {},
      })
    end,
  }


  -- UI
  use "TymekDev/tokyonight.nvim"

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        signs = false,
      })
    end,
  }

  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          inactive = true,
        },
        context = 0,
        expand = {
          -- markdown
          "paragraph",
          "fenced_code_block",
          "list",
        }
      })
    end,
  }

  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        plugins = {
          twilight = { enabled = false },
        },
      })
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "ColorScheme",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("lualine").setup({})
    end,
  }


  -- Others
  use "TymekDev/repos.nvim"
  use "TymekDev/vim-eunuch"
  use { "rust-lang/rust.vim", ft = "rust" }

  use {
    "ray-x/go.nvim",
    ft = "go",
    config = function()
      require("go").setup()
    end,
  }


  -- Builtins
  vim.api.nvim_cmd({ cmd = "packadd", args = { "cfilter" } }, {})


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
