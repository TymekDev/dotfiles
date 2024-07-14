---@module "lazy"
---@type LazySpec
return {
  "TymekDev/freeze.nvim",
  cmd = "Freeze",
  ---@module "freeze"
  ---@type freeze.Options
  opts = {
    theme = function()
      if require("tymek.theme").mode == "light" then
        return require("freeze.themes").tokyonight_day
      end
      return require("freeze.themes").tokyonight_storm
    end,
  },
}
