---@module "lazy"
---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  dependencies = {
    { "Bilal2453/luvit-meta" }, -- vim.uv
    { "justinsgithub/wezterm-types" }, -- wezterm
  },
  ---@module "lazydev"
  ---@type lazydev.Config
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "wezterm-types", mods = { "wezterm" } },
      { path = vim.fn.expand("~/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations"), words = { "hs%." } },
    },
  },
}
