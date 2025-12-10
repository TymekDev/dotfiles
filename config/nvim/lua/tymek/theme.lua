local M = {
  ---@type tymek.theme.Mode
  mode = nil,
}

---@enum (key) tymek.theme.Mode
local themes = {
  light = "tokyonight-day",
  dark = "tokyonight-storm",
}

---@param callback fun(result: string|nil)
local read_mode = function(callback)
  vim.system(
    {
      "cat",
      vim.fn.expand("~/.local/state/tymek-theme/mode"),
    },
    { text = true },
    ---@param out vim.SystemCompleted
    vim.schedule_wrap(function(out)
      if out.code ~= 0 then
        callback(nil)
        return
      end

      callback(vim.trim(out.stdout))
    end)
  )
end

M.update = function()
  read_mode(function(mode)
    mode = mode or "dark"
    M.mode = mode

    vim.api.nvim_cmd({
      cmd = "colorscheme",
      args = { themes[mode] },
    }, {})

    require("nvim-highlight-colors").turnOn()
  end)
end

return M
