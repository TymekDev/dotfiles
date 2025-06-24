local M = {
  ---@type tymek.theme.Mode
  mode = nil,
}

---@alias tymek.theme.Mode "light"|"dark"

---@enum (key) tymek.theme.Theme
local themes = {
  ---@type table<tymek.theme.Mode, string>
  rosepine = {
    light = "rose-pine-dawn",
    dark = "roes-pine-moon",
  },
  ---@type table<tymek.theme.Mode, string>
  tokyonight = {
    light = "tokyonight-day",
    dark = "tokyonight-storm",
  },
}

---@param callback fun(mode: tymek.theme.Mode|nil, theme: tymek.theme.Theme|nil)
local detect = function(callback)
  vim.system(
    {
      "cat",
      vim.fn.expand("~/.local/state/tymek-theme"),
    },
    { text = true },
    ---@param obj vim.SystemCompleted
    vim.schedule_wrap(function(obj)
      if obj.code ~= 0 then
        callback(nil, nil)
        return
      end

      local result = vim.json.decode(vim.trim(obj.stdout))
      callback(result.mode, result.theme)
    end)
  )
end

M.update = function()
  detect(function(mode, theme)
    if theme ~= nil and themes[theme] == nil then
      vim.notify(string.format("[ERROR] Unknown theme: '%s'", theme), vim.log.levels.ERROR)
      return
    end

    mode = mode or "dark"
    theme = theme or "tokyonight"
    M.mode = mode

    vim.api.nvim_cmd({
      cmd = "colorscheme",
      args = { themes[theme][mode] },
    }, {})

    if theme == "tokyonight" and mode == "light" then
      vim.api.nvim_cmd({ cmd = "highlight", args = { "Normal", "guibg=#f1f2f7" } }, {})
      vim.api.nvim_cmd({ cmd = "highlight", args = { "SignColumn", "guibg=none" } }, {})
    end

    require("nvim-highlight-colors").turnOn()
  end)
end

return M
