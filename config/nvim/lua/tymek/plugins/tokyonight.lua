---@module "lazy"
---@type LazySpec
return {
  "folke/tokyonight.nvim",
  priority = 999,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("tokyonight").setup({
      style = "storm",
      lualine_bold = true,
      on_highlights = function(hl, c)
        hl["@r.reactive.call"] = { link = "Special" }
        hl["@r.box.unused.import"] = { link = "Error" }
        hl.NvimSurroundHighlight = { link = "IncSearch" }

        if c.bg == "#e1e2e7" then -- light mode
          hl.Normal.bg = "#f1f2f7"
          hl.SignColumn.bg = c.none
        end
      end,
    })
  end,
}
