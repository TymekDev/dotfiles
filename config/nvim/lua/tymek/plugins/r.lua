local commands = {
  "devtools::load_all()",
  "logger::log_threshold(logger::DEBUG)",
}
local command_last
local command_execute = function()
  vim.ui.select(commands, { prompt = "Execute in R" }, function(cmd)
    if cmd ~= nil then
      command_last = cmd
      vim.cmd.RSend(cmd)
    end
  end)
end

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
    { "<Leader>re", command_execute, desc = "Execute one of a predefined commands in R (via R.nvim)" },
    {
      "<Leader>rr",
      function()
        if command_last ~= nil then
          vim.cmd.RSend(command_last)
        else
          command_execute()
        end
      end,
      desc = "Repeat last command executed with <Leader>re (via R.nvim)",
    },
  },
  opts = {
    setwd = "nvim",
    hl_term = false,
  },
}
