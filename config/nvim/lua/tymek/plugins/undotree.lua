---@module "lazy"
---@type LazySpec
return {
  "mbbill/undotree",
  cmd = { "UndotreeFocus", "UndotreeToggle" },
  keys = {
    { "<Leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Open the undo tree visualization (via undotree)" },
  },
}
