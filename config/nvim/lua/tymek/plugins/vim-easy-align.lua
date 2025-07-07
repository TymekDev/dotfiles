---@module "lazy"
---@type LazySpec
return {
  "junegunn/vim-easy-align", -- TODO: review config
  keys = {
    { mode = { "n", "v" }, "<Leader>a", "<Plug>(EasyAlign)" },
  },
}
