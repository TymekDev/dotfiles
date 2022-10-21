vim.api.nvim_create_user_command("Startup", function()
  local worktrees = vim.split(vim.fn.system({ "git", "worktree", "list" }), "\n", { plain = true, trimempty = true })

  if worktrees[1]:find("%(bare%)$") ~= nil then
    if #worktrees == 1 then
      -- Empty bare repo
      require("telescope").extensions.git_worktree.create_git_worktree()
      goto repos
    end
    if vim.fn.getcwd() == worktrees[1]:gsub("%s*%(bare%)$", "") then
      -- Root of non-empty bare repo
      require("telescope").extensions.git_worktree.git_worktrees()
      goto repos
    end
  end

  -- No repo, non-bare repo, and a worktree of bare repo
  require("telescope.builtin").find_files()

  ::repos::
  require("repos").run()
end, {})


local wider_active_buf = vim.opt.winwidth:get() > vim.opt.winwidth._info.default
vim.api.nvim_create_user_command("WiderActiveBufToggle", function()
  if wider_active_buf then
    vim.opt.winwidth = vim.opt.winwidth._info.default
    vim.cmd("normal =")
  else
    vim.opt.winwidth = 87
  end
  wider_active_buf = not wider_active_buf
end, {})
