---@module "lazy"
---@type LazySpec
return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Open the parent directory (via oil.nvim)" },
    {
      "<Leader>c",
      function()
        vim.system({ "tmux", "new-window", "-c", require("oil").get_current_dir(0) })
      end,
      ft = "oil",
      nowait = true,
      desc = "Open the current directory in a new tmux window (via oil.nvim)",
    },
  },
  ---@module "oil"
  ---@type oil.setupOpts
  opts = {
    keymaps = {
      ["<C-s>"] = false,
      ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<Leader><C-v>"] = { "<C-v>", desc = "Start Visual Block mode in the oil buffer" },
    },
    view_options = {
      show_hidden = true,
    },
  },
}
