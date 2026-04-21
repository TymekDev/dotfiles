vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, { confirm = false })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "astro",
    "bash",
    "css",
    "fish",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "nix",
    "python",
    "r",
    "rust",
    "scss",
    "templ",
    "toml",
    "typescript",
    "yaml",
  },
  callback = function(ev)
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start(ev.buf)
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    -- TODO: switch to conform
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- HTML-ish tags
vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" }, { confirm = false })
require("nvim-ts-autotag").setup()

-- Auto-closing brackets
vim.pack.add({ "https://github.com/windwp/nvim-autopairs" }, { confirm = false })
require("nvim-autopairs").setup({
  fast_wrap = {},
})

-- Commentstring extension
vim.pack.add({ "https://github.com/folke/ts-comments.nvim" }, { confirm = false })
require("ts-comments").setup({
  lang = {
    jsdoc = { "/** %s */ " },
    r = {
      "# %s",
      "#' %s",
    },
  },
})
