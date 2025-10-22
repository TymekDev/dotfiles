---@module "lazy"
---@type LazySpec
return {
  "stevearc/quicker.nvim",
  event = "VeryLazy",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    max_filename_width = function()
      return 30
    end,
    keys = {
      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context (via quicker.nvim)",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context (via quicker.nvim)",
      },
      {
        "]q",
        function()
          local items = vim.fn.getqflist()
          local lnum = vim.api.nvim_win_get_cursor(0)[1]
          for i = lnum + 1, #items do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
          -- Wrap around the end of quickfix list
          for i = 1, lnum do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
        end,
        desc = "Go to the next entry without jumping to its location (via quicker.nvim)",
      },
      {
        "[q",
        function()
          local items = vim.fn.getqflist()
          local lnum = vim.api.nvim_win_get_cursor(0)[1]
          for i = lnum - 1, 1, -1 do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
          -- Wrap around the start of quickfix list
          for i = #items, lnum, -1 do
            if items[i].valid == 1 then
              vim.api.nvim_win_set_cursor(0, { i, 0 })
              return
            end
          end
        end,
        desc = "Go to the previous entry without jumping to its location (via quicker.nvim)",
      },
    },
    trim_leading_whitespace = false,
    use_default_opts = false,
  },
}
