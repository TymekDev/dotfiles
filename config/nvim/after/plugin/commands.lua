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

vim.api.nvim_create_user_command("MarkdownTableSeparator", "s/[^|]/-/g", {})

local run_lintr = function(code)
  vim.system(
    {
      "Rscript",
      "-e",
      code,
    },
    {},
    vim.schedule_wrap(function(result)
      local lines = vim.split(result.stdout, "\n")

      local ok, msg = pcall(vim.fn.setqflist, {}, " ", { lines = lines, efm = [[%f:%l:%c:\ %m]] })
      if not ok then
        vim.notify(msg --[[@as string]], vim.log.levels.ERROR)
      end

      vim.cmd.copen()
    end)
  )
end

vim.api.nvim_create_user_command("RLintPackage", function()
  run_lintr("lintr::lint_package()")
end, {
  desc = "Run lintr::lint_package() and populate the quickfix list with the results",
})

vim.api.nvim_create_user_command("RLintRhino", function()
  run_lintr("rhino::lint_r()")
end, {
  desc = "Run rhino::lint_r() and populate the quickfix list with the results",
})

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
