require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
  },
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvimtreesitter#foldexpr()"
