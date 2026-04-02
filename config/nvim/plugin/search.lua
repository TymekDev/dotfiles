vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
}, { confirm = false })

-- NOTE: git_commits, git_bcommits, and grep_curbuf seem useful. Maybe try them out
local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
  actions = {
    files = {
      true,
      ["ctrl-q"] = {
        fn = actions.buf_sel_to_qf,
        prefix = "select-all+",
      },
    },
  },
})

vim.keymap.set("n", "<C-f>", "<Cmd>FzfLua files<CR>", { desc = "Find files (via fzf-lua)" })
vim.keymap.set("n", "<C-g>", "<Cmd>FzfLua live_grep<CR>", { desc = "Live grep (via fzf-lua)" })
vim.keymap.set("v", "<C-g>", "<Cmd>FzfLua grep_visual<CR>", { desc = "Grep visual selection (via fzf-lua)" })
vim.keymap.set("n", "<Leader>ff", "<Cmd>FzfLua resume<CR>", { desc = "Resume the last search (via fzf-lua)" })
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua helptags<CR>", { desc = "Search through the help tags (via fzf-lua)" })
vim.keymap.set("n", "<Leader>fb", "<Cmd>FzfLua grep_curbuf<CR>")
vim.keymap.set("n", "<Leader>fd", "<Cmd>FzfLua diagnostics_document<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>FzfLua lsp_references<CR>")

vim.keymap.set("n", "<Leader>-", function()
  require("fzf-lua").files({
    cmd = "fd --type d --exclude .git --exclude .jj",
    actions = {
      default = function(selected)
        local entry = require("fzf-lua").path.entry_to_file(selected[1])
        require("oil").open(entry.path)
      end,
    },
  })
end, { desc = "Find directories (via fzf-lua)" })
