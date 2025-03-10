---@module "lazy"
---@type LazySpec
return {
  "nvim-neorg/neorg",
  lazy = false, -- FIXME: highlighting breaks when Neorg is lazy loaded
  ft = "norg",
  keys = {
    { "<Leader>C", "<Cmd>Neorg toggle-concealer<CR>", ft = "norg", desc = "Toggle concealer (via neorg.nvim)" },
  },
  ---@module "neorg"
  ---@type neorg.configuration.user
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            personal = "~/Documents/dokumenty/notatki",
            work = "~/work/notes",
          },
        },
      },
      -- TODO: enable once https://github.com/nvim-neorg/neorg/issues/1579 is fixed
      ["core.esupports.metagen"] = { config = { update_date = false } },
    },
  },
}
