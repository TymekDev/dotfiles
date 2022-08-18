if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- NOTE: colorscheme has to be set before changing highlight groups
vim.cmd("colorscheme nord")
require("lualine").setup({ options = { theme = "nord" }})


-- Overrides
local Color, colors, Group, _, styles = require("colorbuddy").setup()

Color.new("red",   "#BF616A")
Color.new("green", "#A3BE8C")

Group.new("diffAdded",   colors.green, colors.none, styles.none)
Group.new("diffRemoved", colors.red,   colors.none, styles.none)
