local M = {}

---@enum (key) tymek.theme.Mode
local themes = {
  light = "tokyonight-day",
  dark = "tokyonight-storm",
}

---@param callback fun(mode: tymek.theme.Mode)
local read_mode = function(callback)
  vim.system(
    { "are-we-dark-yet" },
    { text = true },
    ---@param out vim.SystemCompleted
    vim.schedule_wrap(function(out)
      if out.code ~= 0 then
        vim.notify("failed to read the system appearance:" .. out.stderr, vim.log.levels.ERROR)
        return
      end

      callback(vim.trim(out.stdout))
    end)
  )
end

M.update = function()
  read_mode(function(mode)
    vim.api.nvim_cmd({
      cmd = "colorscheme",
      args = { themes[mode] },
    }, {})

    require("nvim-highlight-colors").turnOn()
  end)
end

return M
