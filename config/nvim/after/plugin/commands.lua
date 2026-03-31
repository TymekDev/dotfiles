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

