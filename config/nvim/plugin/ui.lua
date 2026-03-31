-- The one and only colorscheme
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

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 50,
    })
  end,
})

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

--  File browser
vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { confirm = false })
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<Leader><C-v>"] = { "<C-v>", desc = "Start Visual Block mode in the oil buffer" },
  },
})
vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open the parent directory (via oil.nvim)" })

-- Icon pack used by various plugins
vim.schedule(function()
  vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" }, { confirm = false })
end)

-- Floating vim.ui.input
vim.schedule(function()
  vim.pack.add({ "https://github.com/stevearc/dressing.nvim" }, { confirm = false })
  require("dressing").setup({
    input = {
      relative = "cursor",
      insert_only = false,
    },
  })
end)

-- Color codes highlighting
vim.schedule(function()
  vim.pack.add({ "https://github.com/brenoprata10/nvim-highlight-colors" }, { confirm = false })
  require("nvim-highlight-colors").setup({ enable_tailwind = true })
end)

-- TODO comments highlighting
vim.schedule(function()
  vim.pack.add({ "https://github.com/folke/todo-comments.nvim" }, { confirm = false })
  require("todo-comments").setup({ signs = false })
end)

-- Sign column git changes, misc
vim.schedule(function()
  vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" }, { confirm = false })
  require("gitsigns").setup({
    on_attach = function(bufnr)
      vim.keymap.set(
        { "n", "v" },
        "[g",
        "<Cmd>Gitsigns prev_hunk<CR>",
        { buffer = bufnr, desc = "Jump to the previous git hunk (via gitsigns.nvim)" }
      )
      vim.keymap.set(
        { "n", "v" },
        "]g",
        "<Cmd>Gitsigns next_hunk<CR>",
        { buffer = bufnr, desc = "Jump to the next git hunk (via gitsigns.nvim)" }
      )
    end,
  })
end)

-- Everything quickfix list
vim.schedule(function()
  vim.pack.add({ "https://github.com/stevearc/quicker.nvim" }, { confirm = false })
  require("quicker").setup({
    trim_leading_whitespace = false,
    use_default_opts = false,
    max_filename_width = function()
      return 30
    end,
    keys = {
      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context (via quicker.nvim)",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context (via quicker.nvim)",
      },
      {
        "]q",
        function()
          local items = vim.fn.getqflist()
          local lnum = vim.api.nvim_win_get_cursor(0)[1]
          for i = lnum + 1, #items do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
          -- Wrap around the end of quickfix list
          for i = 1, lnum do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
        end,
        desc = "Go to the next entry without jumping to its location (via quicker.nvim)",
      },
      {
        "[q",
        function()
          local items = vim.fn.getqflist()
          local lnum = vim.api.nvim_win_get_cursor(0)[1]
          for i = lnum - 1, 1, -1 do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
          -- Wrap around the start of quickfix list
          for i = #items, lnum, -1 do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
        end,
        desc = "Go to the previous entry without jumping to its location (via quicker.nvim)",
      },
    },
  })
end)

vim.schedule(function()
  vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { confirm = false })
  require("lualine").setup({
    options = {
      extensions = { "fugitive", "oil", "quickfix" },
      sections = {
        lualine_c = {
          { "filename", separator = "" },
          { "%=", separator = "" },
          "r_status",
        },
      },
    },
  })
end)
