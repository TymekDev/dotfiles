---@module "lazy"
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  lazy = false, -- IMPORTANT: this cannot be lazy-loaded, because lsp/ definitions won't be recognized.
}
