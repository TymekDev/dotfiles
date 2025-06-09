---@module "lazy"
---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    build = "make",
    ---@module "avante"
    ---@type avante.Config
    opts = {
      -- provider = "openai",
      -- auto_suggestions_provider = "openai",
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "Avante",
    opts = {
      file_types = { "Avante" },
    },
  },
  "nvim-treesitter/nvim-treesitter",
  "stevearc/dressing.nvim",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  "nvim-tree/nvim-web-devicons",
}
