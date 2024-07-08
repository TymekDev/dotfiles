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
  {
    "hrsh7th/nvim-cmp",
    ---@module "cmp.types"
    ---@type fun(_, opts: cmp.ConfigSchema)
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- vim.uv
  { "justinsgithub/wezterm-types", lazy = true }, -- wezterm
}
