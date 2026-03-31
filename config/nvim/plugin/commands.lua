vim.pack.add({
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/tpope/vim-fugitive",
}, { confirm = false })

vim.keymap.set("n", "<Leader>G", function()
  if not Snacks then
    vim.notify(vim.log.levels.ERROR, "Snacks not found. Is snacks.nvim installed?")
    return
  end

  Snacks.win({
    file = "fugitive://" .. Snacks.git.get_root() .. "/.git//",
    minimal = false,
    border = "rounded",
    height = 0.8,
    -- NOTE: without the closing autocmd, the committing made the floating window stuck.
    on_win = function(win)
      vim.api.nvim_create_autocmd("WinLeave", {
        buffer = 0,
        once = true,
        callback = function()
          win:close()
        end,
      })
    end,
  })
end)

local wider_active_buf = vim.api.nvim_get_option_value("winwidth", {})
  > vim.api.nvim_get_option_info2("winwidth", {}).default
vim.api.nvim_create_user_command("WiderActiveBufToggle", function()
  if wider_active_buf then
    vim.opt.winwidth = vim.api.nvim_get_option_info2("winwidth", {}).default
    vim.cmd("normal =")
  else
    vim.opt.winwidth = 87
  end
  wider_active_buf = not wider_active_buf
end, {})

vim.api.nvim_create_user_command("Task", function(args)
  require("snacks.terminal").open({ "task", args.args }, {
    win = {
      position = "bottom",
    },
  })
end, {
  nargs = 1,
  complete = function()
    local taskfile = vim.fs.root(0, {
      "Taskfile.yml",
      "taskfile.yml",
      "Taskfile.yaml",
      "taskfile.yaml",
      "Taskfile.dist.yml",
      "taskfile.dist.yml",
      "Taskfile.dist.yaml",
      "taskfile.dist.yaml",
    })

    local result = vim.system({ "task", "--list", "--silent", "--taskfile", taskfile }, { text = true }):wait(1000)
    if result.code ~= 0 then
      vim.notify("Failed to retrieve Taskfile tasks: " .. result.stderr, vim.log.levels.ERROR)
      return
    end

    return vim.split(vim.trim(result.stdout), "\n")
  end,
})
