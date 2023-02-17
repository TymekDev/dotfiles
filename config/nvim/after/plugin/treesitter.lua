require("nvim-treesitter.configs").setup({
  auto_install = true,
  autotag = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  context = {
    enable = true,
  },
  playground = {
    enable = true,
  },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

require("treesitter-context").setup({
  patterns = {
    go = {
      "func_literal",
    },
  },
})
