if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

require("tokyonight").setup({
  lualine_bold = true,
  on_highlights = function(hl, c)
    hl.QuickScopePrimary = { fg = c.orange }
    hl.QuickScopeSecondary = {}
  end,
})

vim.api.nvim_cmd({ cmd = "colorscheme", args = { "tokyonight" } }, {})
