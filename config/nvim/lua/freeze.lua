local M = {}

---@enum FreezeTheme
local themes = {
  abap = "abap",
  algol = "algol",
  algol_nu = "algol_nu",
  arduino = "arduino",
  autumn = "autumn",
  average = "average",
  base16_snazzy = "base16-snazzy",
  borland = "borland",
  bw = "bw",
  catppuccin_frappe = "catppuccin-frappe",
  catppuccin_latte = "catppuccin-latte",
  catppuccin_macchiato = "catppuccin-macchiato",
  catppuccin_mocha = "catppuccin-mocha",
  colorful = "colorful",
  doom_one = "doom-one",
  doom_one2 = "doom-one2",
  dracula = "dracula",
  emacs = "emacs",
  evergarden = "evergarden",
  friendly = "friendly",
  fruity = "fruity",
  github_dark = "github-dark",
  github = "github",
  gruvbox_light = "gruvbox-light",
  gruvbox = "gruvbox",
  hr_high_contrast = "hr_high_contrast",
  hrdark = "hrdark",
  igor = "igor",
  lovelace = "lovelace",
  manni = "manni",
  modus_operandi = "modus-operandi",
  modus_vivendi = "modus-vivendi",
  monokai = "monokai",
  monokailight = "monokailight",
  murphy = "murphy",
  native = "native",
  nord = "nord",
  onedark = "onedark",
  onesenterprise = "onesenterprise",
  paraiso_dark = "paraiso-dark",
  paraiso_light = "paraiso-light",
  pastie = "pastie",
  perldoc = "perldoc",
  pygments = "pygments",
  rainbow_dash = "rainbow_dash",
  rose_pine_dawn = "rose-pine-dawn",
  rose_pine_moon = "rose-pine-moon",
  rose_pine = "rose-pine",
  rrt = "rrt",
  solarized_dark = "solarized-dark",
  solarized_dark256 = "solarized-dark256",
  solarized_light = "solarized-light",
  swapoff = "swapoff",
  tango = "tango",
  tokyonight_day = "tokyonight-day",
  tokyonight_moon = "tokyonight-moon",
  tokyonight_night = "tokyonight-night",
  tokyonight_storm = "tokyonight-storm",
  trac = "trac",
  vim = "vim",
  vs = "vs",
  vulcan = "vulcan",
  witchhazel = "witchhazel",
  xcode_dark = "xcode-dark",
  xcode = "xcode",
}

---@class FreezeOptions
---@field config? "base"|"full"|"user"|string
---@field font.family? string
---@field theme? FreezeTheme
local defaults = {
  config = "full",
  ["font.family"] = "JetBrainsMono Nerd Font",
  theme = themes.catppuccin_mocha,
}

---@param flags table<string, string>
---@return string[] cmd A command table to be used with vim.system()
local cmd_from_flags = function(flags)
  local cmd = { "freeze" }
  for opt, value in pairs(flags) do
    table.insert(cmd, "--" .. opt)
    table.insert(cmd, value)
  end
  table.insert(cmd, vim.fn.expand("%:p"))
  return cmd
end

---@param path string
---@return string[]
local cmd_copy = function(path)
  return {
    "osascript",
    "-e",
    string.format('set the clipboard to (read (POSIX file "%s") as  {«class PNGf»})', path),
  }
end

---@overload fun(cmd: string[])
---@overload fun(cmd: string[], on_success: fun())
local run_cmd = function(cmd, on_success)
  vim.system(cmd, {}, function(result)
    if result.code ~= 0 then
      error(string.format("Failed to run %s: exit status %d", cmd[1], result.code))
    end
    if type(on_success) == "function" then
      on_success()
    end
  end)
end

---@overload fun(lines: [number, number])
---@overload fun(lines: [number, number], opts: FreezeOptions)
M.generate_and_copy = function(lines, opts)
  ---@type table<string, string>
  local flags = vim.tbl_deep_extend("force", defaults, opts or {})
  flags.lines = table.concat(lines, ",")
  flags.output = vim.fn.tempname() .. ".png"
  run_cmd(cmd_from_flags(flags), function()
    run_cmd(cmd_copy(flags.output))
  end)
end

M.setup = function()
  vim.api.nvim_create_user_command(
    "Freeze",
    ---@param opts { args: string, line1: number, line2: number }
    function(opts)
      local opts_freeze = {}
      if opts.args ~= "" then
        opts_freeze.theme = themes[opts.args]
        if opts_freeze.theme == nil then
          error(string.format("Theme not found: '%s'", opts.args))
        end
      end
      M.generate_and_copy({ opts.line1, opts.line2 }, opts_freeze)
    end,
    {
      range = true,
      nargs = "?",
      complete = function()
        return vim.tbl_keys(themes)
      end,
    }
  )
end

return M
