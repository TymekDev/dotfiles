-- TODO: use lspkind
-- TODO: setup lspking with R.nvim: https://github.com/R-nvim/cmp-r?tab=readme-ov-file#nvim-cmp

---@module "lazy"
---@type LazySpec
return {
  {
    "hrsh7th/nvim-cmp",
    -- FIXME: this appears to be loaded immediately on startup
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
      "R-nvim/cmp-r",
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "hrsh7th/cmp-path",
    },
    opts = function()
      ---@module "cmp.types"
      ---@type cmp.ConfigSchema
      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = require("cmp").config.sources({
          { name = "lazydev", group_index = 0 },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "cmp_r" },
          { name = "neorg" },
          { name = "luasnip" },
          { name = "path", option = { trailing_slash = true } },
        }),
      }
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "cmdline" },
        }),
      })
    end,
  },
}
