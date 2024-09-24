local is_fence = function(x)
  return string.match(x, "^=+$") ~= nil
end

vim.api.nvim_buf_create_user_command(
  0,
  "Wrap",
  ---@param tbl { line1: number, line2: number }
  function(tbl)
    local idx_start = tbl.line1 - 1
    local idx_end = tbl.line2
    local lines = vim.api.nvim_buf_get_lines(0, idx_start, idx_end, true)

    -- Exclude existing fences (unless the only line is a fence)
    if #lines > 1 and is_fence(lines[1]) then
      table.remove(lines, 1)
    end
    if #lines > 1 and is_fence(lines[#lines]) then
      table.remove(lines, #lines)
    end

    -- Look behind and ahead to check for fences
    local line_before = vim.api.nvim_buf_get_lines(0, idx_start - 1, idx_start, false)
    if #line_before == 1 and is_fence(line_before[1]) then
      idx_start = idx_start - 1
    end
    local line_after = vim.api.nvim_buf_get_lines(0, idx_end, idx_end + 1, false)
    if #line_after == 1 and is_fence(line_after[1]) then
      idx_end = idx_end + 1
    end

    local max_line_length = vim.iter(lines):fold(0, function(max_len, line)
      return math.max(max_len, #line)
    end)
    local fence = string.rep("=", max_line_length)
    table.insert(lines, 1, fence)
    table.insert(lines, fence)
    vim.api.nvim_buf_set_lines(0, idx_start, idx_end, true, lines)
  end,
  {
    desc = "Wrap the selection in fences (repeated '=') that match the length of the longest selected line",
    range = true,
  }
)

vim.keymap.set("n", "<Leader>w", "vip<Leader>w", { buffer = 0, remap = true })
vim.keymap.set("v", "<Leader>w", ":Wrap<CR>", { buffer = 0 })
