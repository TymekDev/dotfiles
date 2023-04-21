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
}

require("lazy").setup(plugins, opts)
