---@module "lazy"
---@type LazySpec
return {
  {
    "R-nvim/R.nvim",
    ft = "r",
    opts = {
      setwd = "nvim",
      hl_term = false,
    },
  },
  "R-nvim/cmp-r",
}
