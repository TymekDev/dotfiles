local adapter = {
  name = "copilot",
  model = "claude-3.7-sonnet",
}

---@module "lazy"
---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
  opts = {
    strategies = {
      chat = {
        adapter = adapter,
      },
      inline = {
        adapter = adapter,
      },
      cmd = {
        adapter = adapter,
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = { keymap = "gH" },
      },
    },
  },
}
