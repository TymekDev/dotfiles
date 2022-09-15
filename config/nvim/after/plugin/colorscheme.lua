if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- NOTE: colorscheme has to be set before changing highlight groups
vim.cmd("colorscheme nord")
require("lualine").setup()


-- Overrides
local Color, colors, Group, _, styles = require("colorbuddy").setup()

Color.new("green",  "#A3BE8C")
Color.new("red",    "#BF616A")
Color.new("yellow", "#EBCB8B")

Group.new("diffAdded",   colors.green, colors.none, styles.none)
Group.new("diffRemoved", colors.red,   colors.none, styles.none)
Group.new("QuickScopePrimary", colors.yellow, colors.none, styles.undercurl)
Group.new("QuickScopeSecondary", colors.none, colors.none, styles.none)
