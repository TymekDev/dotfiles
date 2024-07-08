return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      library = {
        "~/.config/nvim/lua/",
      },
    },
  },
  { -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    ---@module "cmp.types"
    ---@type fun(_, opts: cmp.ConfigSchema)
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
