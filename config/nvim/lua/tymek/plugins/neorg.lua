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
      ["core.completion"] = { config = { engine = "nvim-cmp" } },
      ["core.dirman"] = {
        config = {
          workspaces = {
            personal = "~/Documents/dokumenty/notatki",
            work = "~/work/notes",
          },
        },
      },
    },
  },
}
