vim.schedule(function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" }, { confirm = false })
  vim.lsp.enable({
    "air",
    "astro",
    "bashls",
    "cssls",
    "emmet_language_server",
    "fish_lsp",
    "golangci_lint_ls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "nixd",
    "r_language_server",
    "ruff",
    "tailwindcss",
    "taplo",
    "templ",
    "ts_ls",
    "ty",
    "unocss",
    "yamlls",
  })
  vim.lsp.inlay_hint.enable()

  vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
  })
end)

vim.schedule(function()
  vim.pack.add({ "https://github.com/folke/lazydev.nvim" }, { confirm = false })
  vim.pack.add({ "https://github.com/justinsgithub/wezterm-types" }, { load = function() end }) -- NOP load
  require("lazydev").setup({
    library = {
      { path = "wezterm-types", mods = { "wezterm" } },
      { path = vim.fn.expand("~/.config/hammerspoon/Spoons/EmmyLua.spoon/annotations"), words = { "hs%." } },
    },
  })
end)

vim.keymap.set("i", "<M-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "gK", vim.diagnostic.open_float)
vim.keymap.set("n", "gqd", vim.diagnostic.setqflist)
vim.keymap.set("n", "<Leader>D", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.keymap.set("n", "[D", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "]D", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
end)
