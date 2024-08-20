---@module "lazy"
---@type LazySpec
return {
  "m4xshen/hardtime.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    disable_mouse = false,
    restriction_mode = "hint",
    hints = {
      ["dd"] = {
        message = function()
          return "Use Vd or VD instead of dd"
        end,
        length = 2,
      },
      ["yy"] = {
        message = function()
          return "Use Vy or VY instead of yy"
        end,
        length = 2,
      },
    },
  },
}
