---@module "lazy"
---@type LazySpec
return {
  "nvim-lualine/lualine.nvim", -- TODO: review config
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    extensions = { "fugitive", "oil", "quickfix" },
    sections = {
      lualine_c = {
        { "filename", separator = "" },
        { "%=", separator = "" },
        "r_status",
      },
    },
  },
}
