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
    dark = "rose-pine-moon",
  },
  ---@type table<tymek.theme.Mode, string>
  tokyonight = {
    light = "tokyonight-day",
    dark = "tokyonight-storm",
  },
}

---@param filename "theme"|"mode"
---@param callback fun(result: string|nil)
local read = function(filename, callback)
  vim.system(
    {
      "cat",
      vim.fn.expand(string.format("~/.local/state/tymek-theme/%s", filename)),
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

---@param callback fun(theme: tymek.theme.Theme|nil, mode: tymek.theme.Mode|nil)
local detect = function(callback)
  read("theme", function(theme)
    read("mode", function(mode)
      callback(theme, mode)
    end)
  end)
end

M.update = function()
  detect(function(theme, mode)
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
