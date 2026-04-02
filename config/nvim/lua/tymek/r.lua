local M = {}

---@type string?
local last_command

---@type table<string, fun()>
local COMMANDS = {
  ["devtools::load_all()"] = function()
    vim.cmd.RSend("devtools::load_all()")
  end,
  ["logger::log_threshold(logger::DEBUG)"] = function()
    vim.cmd.RSend("logger::log_threshold(logger::DEBUG)")
  end,
  ["logger::log_threshold(...)"] = function()
    vim.ui.select(
      { "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL" },
      { prompt = "Select the log level" },
      function(input)
        if input == nil then
          return
        end

        vim.cmd.RSend(string.format("logger::log_threshold(logger::%s)", input))
      end
    )
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

M.exec_last_command = function()
  if M.last_command == nil then
    M.select_command()
    return
  end
  COMMANDS[last_command]()
end

M.exec_command = function()
  vim.ui.select(vim.tbl_keys(COMMANDS), { prompt = "Execute in R" }, function(cmd)
    if cmd ~= nil then
      last_command = cmd
      COMMANDS[cmd]()
    end
  end)
end

return M
