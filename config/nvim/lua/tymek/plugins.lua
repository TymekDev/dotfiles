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

local opts = {
  install = {
    colorscheme = { "tokyonight" },
  },
}

local plugins = {
  {
    "TymekDev/tokyonight.nvim",
    lazy = false,
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
    dependencies = { "nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter"  },
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
    end
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
}

require("lazy").setup(plugins, opts)
