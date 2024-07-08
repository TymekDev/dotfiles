---@module "lazy"
---@type LazySpec
return {
  "kylechui/nvim-surround",
  keys = {
    -- stylua: ignore start
    { "ys", "<Plug>(nvim-surround-normal)", desc = "Surround a motion (via nvim-surround)" },
    { "yss", "<Plug>(nvim-surround-normal-cur)", desc = "Surround the current line (via nvim-surround)" },
    { "yS", "<Plug>(nvim-surround-normal-line)", desc = "Surround a motion, place surrounding on new lines (via nvim-surround)" },
    { "ySS", "<Plug>(nvim-surround-normal-cur-line)", desc = "Surround the current line, place surrounding on new lines (via nvim-surround)" },
    { "S", "<Plug>(nvim-surround-visual)", desc = "Surround the selection (via nvim-surround)" },
    { "gS", "<Plug>(nvim-surround-visual-line)", desc = "Surround the selection, place surrounding on new lines (via nvim-surround)" },
    { "ds", "<Plug>(nvim-surround-delete)", desc = "Delete the surrounding (via nvim-surround)" },
    { "cs", "<Plug>(nvim-surround-change)", desc = "Change the surrounding (via nvim-surround)" },
    { "cS", "<Plug>(nvim-surround-change-line)", desc = "Change the surrounding (via nvim-surround)" },
    -- stylua: ignore stop
  },
  ---@module "nvim-surround"
  ---@type user_options
  opts = {
    move_cursor = false,
  },
}
