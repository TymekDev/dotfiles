require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.export"] = {},
    ["core.gtd.base"] = {
      config = {
        workspace = "work",
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.norg.concealer"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          work = "~/work/notes",
        },
      },
    },
  },
})
