vim.pack.add({ "https://github.com/folke/tokyonight.nvim" }, { confirm = false })
require("tokyonight").setup({ ---@diagnostic disable-line: missing-fields
  style = "storm",
  lualine_bold = true,
  on_highlights = function(hl, c)
    hl["@r.reactive.call"] = { link = "Special" }
    hl["@r.box.unused.import"] = { link = "Error" }
    hl.NvimSurroundHighlight = { link = "IncSearch" }

    if c.bg == "#e1e2e7" then -- light mode
      hl.Normal.bg = "#f1f2f7"
      hl.SignColumn.bg = c.none
    end
  end,
})

vim.cmd.colorscheme("tokyonight")

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.system(
      { "are-we-dark-yet" },
      { text = true },
      ---@param out vim.SystemCompleted
      function(out)
        if out.code ~= 0 then
          vim.notify("failed to read the system appearance:" .. out.stderr, vim.log.levels.ERROR)
          return
        end

        local mode = vim.trim(out.stdout)
        vim.schedule(function()
          vim.o.background = mode
          require("nvim-highlight-colors").turnOn()
        end)
      end
    )
  end,
})

vim.schedule(function()
  vim.pack.add({ "https://github.com/stevearc/dressing.nvim" }, { confirm = false })
  require("dressing").setup({
    input = {
      relative = "cursor",
      insert_only = false,
    },
  })
end)

vim.schedule(function()
  vim.pack.add({ "https://github.com/brenoprata10/nvim-highlight-colors" }, { confirm = false })
  require("nvim-highlight-colors").setup({ enable_tailwind = true })
end)

vim.schedule(function()
  vim.pack.add({ "https://github.com/folke/todo-comments.nvim" }, { confirm = false })
  require("todo-comments").setup({ signs = false })
end)
