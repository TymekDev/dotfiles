local commands = {
  "devtools::load_all()",
}

---@module "lazy"
---@type LazySpec
return {
  "R-nvim/R.nvim",
  ft = "r",
  keys = {
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
