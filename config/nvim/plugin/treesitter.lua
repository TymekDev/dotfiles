vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name ~= "nvim-treesitter" or kind ~= "update" then
      return
    end

    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
    end

    vim.cmd("TSUpdate")
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, { confirm = false })
require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "?*",
  callback = function(ev)
    -- syntax highlighting, provided by Neovim
    pcall(vim.treesitter.start, ev.buf)
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    -- TODO: switch to conform
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Context at the top of the window
vim.schedule(function()
  vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context" }, { confirm = false })
  require("treesitter-context").setup({
    max_lines = 5,
  })
end)

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
