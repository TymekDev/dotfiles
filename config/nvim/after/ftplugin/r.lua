-- vim:foldenable
local queries = require("tymek.treesitter.queries.r")
local ts = require("tymek.treesitter")
local ts_r = require("tymek.treesitter.r")

vim.g.r_indent_align_args = false
vim.opt_local.textwidth = 100

vim.keymap.set({ "n", "i" }, "<M-p>", function()
  local bufnr = 0
  local line_index = vim.api.nvim_win_get_cursor(bufnr)[1]
  local line = vim.api.nvim_buf_get_lines(bufnr, line_index - 1, line_index, true)[1] .. " |>"
  vim.api.nvim_buf_set_lines(bufnr, line_index - 1, line_index, true, { line })
end, {
  buffer = 0,
  desc = "Append a native pipe to the end of the current line",
})
vim.keymap.set("i", "<M-,>", " <- ")
vim.keymap.set("n", "<Leader>bi", ts_r.put_missing_box_imports, { buffer = 0 })

vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
  desc = "Highlight reactives and eventReactives declared in the current buffer",
  buffer = 0,
  callback = function(args)
    local reactives_names = vim.tbl_keys(ts.get_matches(args.buf, "r", queries.reactives_declarations, "target"))
    ts.highlight_nodes(
      args.buf,
      "r",
      queries.calls(reactives_names),
      vim.api.nvim_create_namespace("reactive_calls"),
      "@r.reactive.call"
    )
  end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
  -- NOTE: This works only for imports from packages (i.e. not from files).
  -- NOTE: There might be false positives when importing non-function objects.
  desc = "Highlight unused imports in box::use()",
  buffer = 0,
  callback = function(args)
    local calls = ts.get_matches(args.buf, "r", queries.calls(), "target")
    ts.highlight_nodes(
      args.buf,
      "r",
      queries.box_imports,
      vim.api.nvim_create_namespace("box_unused_imports"),
      "@r.box.unused.import",
      function(capture_name, node)
        if capture_name ~= "box.use.function" then
          return false
        end
        local call = vim.treesitter.get_node_text(node, args.buf)
        return not calls[call]
      end
    )
  end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
  desc = "Highlight roxygen2 tags",
  buffer = 0,
  callback = function(args)
    local ok, msg = pcall(ts_r.highlight_roxygen2_comments, args.buf)
    if not ok then
      vim.notify("failed to highlight roxygen2 comments: " .. msg, vim.log.levels.DEBUG)
    end
  end,
})
