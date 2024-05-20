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

vim.g.mapleader = " "
require("lazy").setup(
  "tymek.plugins",
  {
    install = {
      colorscheme = { "tokyonight" },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "editorconfig",
          "gzip",
          "health",
          "man",
          "matchit",
          -- "matchparen",
          "netrwPlugin",
          "nvim",
          "rplugin",
          -- "shada",
          -- "spellfile",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }
)

vim.api.nvim_cmd({
  cmd = "packadd",
  args = { "cfilter" },
}, {})

require("tymek.mappings").setup()
