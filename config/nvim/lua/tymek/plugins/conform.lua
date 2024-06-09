return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>F", "<Cmd>FormatToggle<CR>", desc = "Toggle autoformat-on-save (via conform.nvim)" },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      if vim.bo[bufnr].filetype == "html" then
        return { timeout_ms = 2000 }
      end
      return { timeout_ms = 2000, lsp_fallback = true }
    end,
    formatters_by_ft = {
      ["*"] = {
        { "prettierd", "prettier" },
      },
      go = {
        { "gofumpt", "gofmt" },
        "goimports",
      },
      lua = {
        "stylua",
      },
      yaml = {
        "yamlfmt",
      },
    },
  },
  init = function()
    vim.api.nvim_create_user_command("FormatToggle", function(opts)
      if opts.bang then
        vim.g.disable_autoformat = not vim.g.disable_autoformat or false
      else
        vim.b.disable_autoformat = not vim.b.disable_autoformat or false
      end
    end, {
      desc = "Toggle autoformat-on-save for a buffer (add ! to toggle globally)",
      bang = true,
    })
  end,
}
