local commands = {
  "devtools::load_all()",
}

---@module "lazy"
---@type LazySpec
return {
  "R-nvim/R.nvim",
  ft = "r",
  keys = {
    -- EPIC: make this run on-save on tribbles
    {
      "<Leader>ra",
      "<Plug>(EasyAlign)i(<CR>*,",
      desc = "Right-align content of closest parentheses on all commas, e.g. a tribble definition (via vim-easy-align)",
    },
    {
      "<Leader>re",
      function()
        vim.ui.select(commands, { prompt = "Execute in R" }, function(cmd)
          if cmd ~= nil then
            vim.cmd.RSend(cmd)
          end
        end)
      end,
      ft = "r",
      desc = "Execute one of a predefined commands in R (via R.nvim)",
    },
  },
  opts = {
    setwd = "nvim",
    hl_term = false,
  },
}
