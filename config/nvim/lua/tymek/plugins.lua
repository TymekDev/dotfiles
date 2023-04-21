-- bootstrap start
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
-- bootstrap end

require("lazy").setup({
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
  }
})
