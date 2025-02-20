---@module "lazy"
---@type LazySpec
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  dependencies = {
    "saghen/blink.compat",
    "TymekDev/cmp-r",
  },
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
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
    ---@diagnostic disable-next-line: missing-fields
    completion = {
      ---@diagnostic disable-next-line: missing-fields
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
          components = {
            source_name = {
              text = function(ctx)
                if ctx.source_name == "cmp_r" then
                  return "R.nvim"
                end
                return ctx.source_name
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev", "R.nvim" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          fallbacks = { "lsp" },
        },
        ["R.nvim"] = {
          name = "cmp_r",
          module = "blink.compat.source",
        },
      },
    },
  },
}
