---@module "lazy"
---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- vim.uv
  -- FIXME: wezterm types don't really work
  { "justinsgithub/wezterm-types", lazy = true }, -- wezterm
}
