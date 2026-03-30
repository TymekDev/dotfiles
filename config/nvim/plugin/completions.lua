local augroup = vim.api.nvim_create_augroup("load:blink.cmp", { clear = true })
local load_blink = function()
  vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  }, { confirm = false })

  require("blink.cmp").setup({
    keymap = {
      preset = "none",
      ["<C-j>"] = { "show", "select_and_accept", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-k>"] = { "show_documentation", "hide_documentation", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
    },
    cmdline = {
      keymap = {
        preset = "none",
        ["<C-j>"] = { "show", "select_and_accept", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          fallbacks = { "lsp" },
        },
      },
    },
  })

  vim.api.nvim_del_augroup_by_id(augroup)
end

vim.api.nvim_create_autocmd("InsertEnter", { once = true, pattern = "?*", callback = load_blink, group = augroup })
vim.api.nvim_create_autocmd("CmdlineEnter", { once = true, callback = load_blink, group = augroup })

local load_copilot = function()
  vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" }, { confirm = false })
  require("copilot").setup({
    should_attach = function(_, bufname)
      if string.match(bufname, "env") then
        return false
      end
      return true
    end,
    panel = { enabled = false },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<M-j>",
        accept_word = "<M-k>",
        accept_line = "<M-l>",
      },
    },
  })
end

vim.api.nvim_create_autocmd("InsertEnter", { once = true, pattern = "?*", callback = load_copilot })
