---@module "lazy"
---@type LazySpec
return {
  {
    "folke/tokyonight.nvim",
    priority = 999,
    config = function()
      require("tokyonight").setup({
        lualine_bold = true,
        on_highlights = function(hl, _)
          hl["@r.reactive.call"] = { link = "Special" }
          hl["@r.box.unused.import"] = { link = "Error" }
          hl.NvimSurroundHighlight = { link = "IncSearch" }
        end,
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 999,
  },
}
