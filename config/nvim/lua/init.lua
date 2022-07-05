-- Setup Comment.nvim
require("Comment").setup{
  pre_hook = function(ctx)
    local U = require 'Comment.utils'

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
  end,
}


-- Setup nvim-cmp
vim.opt.completeopt={"menu", "menuone", "noselect"}


local source_mapping = {
  buffer = "[Buf]",
  nvim_lsp = "[LSP]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

local cmp = require("cmp")
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<C-j>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}),
  },
  formatting = {
    format = function(entry, vim_item)
      local menu = source_mapping[entry.source.name]
      -- Add prediction %
      if entry.source.name == "cmp_tabnine" then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. " " .. menu
        end
      end
      vim_item.menu = menu
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = "cmp_tabnine" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
  })
})


-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()


-- Setup nvim-treesitter
require("nvim-treesitter.configs").setup{
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}