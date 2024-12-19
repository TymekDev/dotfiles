local M = {
  ---@type tymek.theme.Mode
  mode = nil,
}

---@enum (key) tymek.theme.Mode
local theme = {
  light = "tokyonight-day",
  dark = "tokyonight-storm",
}

---@param callback fun(mode: tymek.theme.Mode|nil)
local detect = function(callback)
  vim.system(
    {
      "cat",
      "/tmp/tymek-theme",
    },
    { text = true },
    ---@param obj vim.SystemCompleted
    vim.schedule_wrap(function(obj)
      if obj.code ~= 0 then
        callback(nil)
        return
      end

      callback(vim.trim(obj.stdout))
    end)
  )
end

M.update = function()
  detect(function(mode)
    mode = mode or "dark"
    M.mode = mode

    vim.api.nvim_cmd({
      cmd = "colorscheme",
      args = { theme[mode] },
    }, {})

    if mode == "light" then
      vim.api.nvim_cmd({ cmd = "highlight", args = { "Normal", "guibg=#f1f2f7" } }, {})
      vim.api.nvim_cmd({ cmd = "highlight", args = { "SignColumn", "guibg=none" } }, {})
    end

    require("nvim-highlight-colors").turnOn()
  end)
end

return M
