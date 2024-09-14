---@module "lazy"
---@type LazySpec
return {
  "nvim-neorg/neorg",
  ft = "norg",
  cmd = "Neorg",
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
          default_workspace = "personal",
          workspaces = {
            personal = "~/Documents/dokumenty/notatki",
          },
        },
      },
    },
  },
}
