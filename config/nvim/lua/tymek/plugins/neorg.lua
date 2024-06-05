return {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = {
    {
      "vhyrro/luarocks.nvim",
      config = true,
    },
  },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.completion"] = { config = { engine = "nvim-cmp" } },
      ["core.dirman"] = {
        config = {
          default_workspace = "work",
          workspaces = {
            work = "~/work/notes",
          },
        },
      },
    },
  },
}
