-- TODO: use lspkind
-- TODO: setup lspking with R.nvim: https://github.com/R-nvim/cmp-r?tab=readme-ov-file#nvim-cmp
---@module "lazy"
---@type LazySpec
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
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
    config = function()
      require("cmp").setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = require("cmp").config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "cmp_r" },
          { name = "luasnip" },
          {
            name = "path",
            option = { trailing_slash = true },
          },
        }),
      })
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("cmp").setup.cmdline(":", {
        sources = require("cmp").config.sources({
          { name = "cmdline" },
        }),
      })
    end,
  },
}
