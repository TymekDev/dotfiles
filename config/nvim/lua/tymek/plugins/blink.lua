---@module "lazy"
---@type LazySpec
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo build --release",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ["<C-j>"] = { "show", "select_and_accept" },
      ["<C-u>"] = { "scroll_documentation_up" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-space>"] = {},
      ["<C-y>"] = {},
      ["<C-b>"] = {},
      ["<C-f>"] = {},
    },
    ---@diagnostic disable-next-line: missing-fields
    completion = {
      ---@diagnostic disable-next-line: missing-fields
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
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
  },
}
