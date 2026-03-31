---@param bufnr integer
---@param ... string Formatters to select a first available one from.
---@see https://github.com/stevearc/conform.nvim/blob/eff40c4f5fdf7ae8f269b258047d1bd7cee50f02/doc/recipes.md#run-the-first-available-formatter-followed-by-more-formatters
---@return string
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

vim.schedule(function()
  vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { confirm = false })

  require("conform").setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 2000 }
    end,
    formatters_by_ft = {
      ["_"] = function(bufnr)
        return {
          first(bufnr, "prettierd", "prettier"),
        }
      end,
      d2 = { "d2" },
      fish = { "fish_indent" },
      go = function(bufnr)
        return {
          first(bufnr, "gofumpt", "gofmt"),
          "goimports",
        }
      end,
      nix = { "nixfmt", "injected" },
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      r = function(bufnr)
        return { first(bufnr, "air", "styler") }
      end,
      query = { "format-queries" },
      sh = { "shfmt", "shellcheck" },
      templ = { "templ" },
      yaml = { "yamlfmt" },
    },
  })

  vim.api.nvim_create_user_command("FormatToggle", function(args)
    if args.bang then
      vim.g.disable_autoformat = not vim.g.disable_autoformat or false
    else
      vim.b.disable_autoformat = not vim.b.disable_autoformat or false
    end
  end, {
    desc = "Toggle autoformat-on-save for a buffer (add ! to toggle globally)",
    bang = true,
  })

  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  vim.keymap.set("n", "<Leader>F", "<Cmd>FormatToggle<CR>", { desc = "Toggle autoformat-on-save (via conform.nvim)" })
end)
