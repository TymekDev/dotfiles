vim.api.nvim_buf_create_user_command(
  0,
  "Wrap",
  ---@param tbl { line1: number, line2: number }
  function(tbl)
    local lines = vim.api.nvim_buf_get_lines(0, tbl.line1 - 1, tbl.line2, true)
    local max_line_length = vim.iter(lines):fold(0, function(max_len, line)
      return math.max(max_len, #line)
    end)
    local fence = string.rep("=", max_line_length)
    table.insert(lines, 1, fence)
    table.insert(lines, fence)
    vim.api.nvim_buf_set_lines(0, tbl.line1 - 1, tbl.line2, true, lines)
  end,
  {
    desc = "Wrap the selection in fences (repeated '=') that match the length of the longest selected line",
    range = true,
  }
)

vim.keymap.set("n", "<Leader>w", "vip<Leader>w", { buffer = 0, remap = true })
vim.keymap.set("v", "<Leader>w", ":Wrap<CR>", { buffer = 0 })
