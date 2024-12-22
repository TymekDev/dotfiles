---@module "snacks"
---@type snacks.win?
local win_fugitive = nil

---@module "lazy"
---@type LazySpec
return {
  "tpope/vim-fugitive",
  cmd = "Git",
  keys = {
    { "<Leader>gf", "<Cmd>Git fetch<CR>", ft = "fugitive", desc = "Run `git fetch` (via vim-fugitive)" },
    { "<Leader>gl", "<Cmd>Git pull<CR>", ft = "fugitive", desc = "Run `git pull` (via vim-fugitive)" },
    -- FEAT: change pushing to run asynchronously (using vim.system())
    { "<Leader>gp", "<Cmd>Git push<CR>", ft = "fugitive", desc = "Run `git push` (via vim-fugitive)" },
    {
      "<Leader>gP",
      "<Cmd>Git push --force-with-lease<CR>",
      ft = "fugitive",
      desc = "Run `git push --force-with-lease` (via vim-fugitive)",
    },
    {
      "<Leader>G",
      function()
        if not Snacks then
          vim.notify(vim.log.levels.ERROR, "Snacks not found. Is snacks.nvim installed?")
          return
        end

        if win_fugitive and win_fugitive:is_floating() then
          win_fugitive:close()
          return
        end

        vim.cmd.Git()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.cmd.quit()

        win_fugitive = Snacks.win({
          buf = bufnr,
          minimal = false,
          border = "rounded",
          height = 0.8,
          wo = {
            winhighlight = "NormalFloat:Normal,FloatBorder:DiagnosticNormal",
          },
          -- NOTE: Otheriwse, committing makes the window stuck.
          -- EPIC: Ideally, it would open in a split or show fugitive after write.
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
      end,
    },
  },
}
