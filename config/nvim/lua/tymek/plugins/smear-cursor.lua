---@module "lazy"
---@type LazySpec
return {
  "sphamba/smear-cursor.nvim",
  opts = {
    -- https://github.com/sphamba/smear-cursor.nvim?tab=readme-ov-file#faster-smear
    stiffness = 0.8,
    trailing_stiffness = 0.6,
    trailing_exponent = 0,
    distance_stop_animating = 0.5,
    hide_target_hack = false,
  },
}
