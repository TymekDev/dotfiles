---@type table<string, fun()>
local commands = {
  ["devtools::load_all()"] = function()
    vim.cmd.RSend("devtools::load_all()")
  end,
  ["logger::log_threshold(logger::DEBUG)"] = function()
    vim.cmd.RSend("logger::log_threshold(logger::DEBUG)")
  end,
  ["renv::install(...)"] = function()
    vim.ui.input({ prompt = "renv::install(...)" }, function(input)
      if input == nil then
        return
      end

      local pkgs = vim.split(input, "%s*,%s*")
      if #pkgs == 1 then
        vim.cmd.RSend(string.format('renv::install("%s", prompt = FALSE)', pkgs[1]))
      end

      local vec = vim
        .iter(pkgs)
        :map(function(pkg)
          return string.format('"%s"', pkg)
        end)
        :join(", ")
      vim.cmd.RSend(string.format("renv::install(c(%s), prompt = FALSE)", vec))
    end)
  end,
}
local command_last
local command_execute = function()
  vim.ui.select(vim.tbl_keys(commands), { prompt = "Execute in R" }, function(cmd)
    if cmd ~= nil then
      command_last = cmd
      commands[cmd]()
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
          commands[command_last]()
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
    pdfviewer = "",
  },
}
