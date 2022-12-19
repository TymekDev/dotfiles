vim.g.mapleader = " "

-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap
local xnoremap = require("tymek.keymap").xnoremap


vim.keymap.set("n", "<Leader>h", "<C-w>h")
vim.keymap.set("n", "<Leader>j", "<C-w>j")
vim.keymap.set("n", "<Leader>k", "<C-w>k")
vim.keymap.set("n", "<Leader>l", "<C-w>l")

vim.keymap.set("n", "<C-p>", vim.cmd.tabprevious)
vim.keymap.set("n", "<C-n>", vim.cmd.tabnext)

vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Half screen up and center on cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Half screen down and center on cursor

vim.keymap.set("n", "n", "nzzzv") -- Next search result, center on cursor, and open folds
vim.keymap.set("n", "N", "Nzzzv") -- Previous search result, center on cursor, and open folds

vim.keymap.set("n", "<C-h>", function() -- Previous quickfix list
  vim.cmd.colder({ count = vim.api.nvim_eval("v:count1") })
  vim.cmd.cwindow()
end)

vim.keymap.set("n", "<C-j>", function() -- Next quickfix entry (with wrapping)
  local ok, msg = pcall(vim.cmd.cnext, { count = vim.api.nvim_eval("v:count1") })
  if ok == false and msg == "Vim:E553: No more items" then
    vim.cmd.cfirst()
  end
  vim.cmd.cwindow()
end)

vim.keymap.set("n", "<C-k>", function() -- Previous quickfix entry (with wrapping)
  local ok, msg = pcall(vim.cmd.cprev, { count = vim.api.nvim_eval("v:count1") })
  if ok == false and msg == "Vim:E553: No more items" then
    vim.cmd.clast()
  end
  vim.cmd.cwindow()
end)

vim.keymap.set("n", "<C-l>", function() -- Next quickfix list
  vim.cmd.cnewer({ count = vim.api.nvim_eval("v:count1") })
  vim.cmd.cwindow()
end)


-- Special buffers and external commands
nnoremap("<Leader><C-e>", { cmd = "Ex" })
nnoremap("<Leader><C-u>", { cmd = "UndotreeToggle" })
nnoremap("<Leader><C-g>", { cmd = "Git" })

nnoremap("<C-s>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<C-_>", "<Cmd>silent !tmux neww tmux-cht.sh<CR>")


-- Registers
xnoremap("<Leader>p", '"_dP') -- don't overwrite paste register
nnoremap("<Leader>y", '"+y') -- copy to system register
xnoremap("<Leader>y", '"+y')
nnoremap("<Leader>Y", '"+Y')
xnoremap("<Leader>Y", '"+Y')


-- Toggles
nnoremap("<Leader>Q", { cmd = "QuickScopeToggle" })
nnoremap("<Leader>W", { cmd = "WiderActiveBufToggle" })
nnoremap("<Leader>R", function() vim.o.relativenumber = not vim.o.relativenumber end)
nnoremap("<Leader>T", { cmd = "Twilight" })
nnoremap("<Leader>P", { cmd = "PlainMode" })
nnoremap("<Leader>Z", { cmd = "ZenMode" })


-- Editing
nnoremap("<Leader>a", "<Plug>(EasyAlign)")
xnoremap("<Leader>a", "<Plug>(EasyAlign)")


-- Harpoon
nnoremap("ghq", require("harpoon.ui").toggle_quick_menu)
nnoremap("gha", require("harpoon.mark").add_file)
nnoremap("gh1", function() require("harpoon.ui").nav_file(1) end)
nnoremap("gh2", function() require("harpoon.ui").nav_file(2) end)
nnoremap("gh3", function() require("harpoon.ui").nav_file(3) end)
nnoremap("gh4", function() require("harpoon.ui").nav_file(4) end)


-- Telescope
nnoremap("<Leader>fq", require("telescope.builtin").quickfix) -- [q]uickfix
-- FIXME: when paths are too long file_browser does not truncate them on picker startup
nnoremap("<Leader>fe", function() require("telescope").extensions.file_browser.file_browser({ cwd = "%:h" }) end) -- [e]xplore (:Ex)
nnoremap("<Leader>ff", require("telescope.builtin").find_files) -- [f]iles
nnoremap("<Leader>fg", require("telescope.builtin").live_grep) -- [g]rep
nnoremap("<Leader>fh", require("telescope.builtin").help_tags) -- [h]elp
nnoremap("<Leader>fc", require("telescope.builtin").commands) -- [c]ommands
nnoremap("<Leader>fb", require("telescope.builtin").current_buffer_fuzzy_find) -- [b]uffer

nnoremap("<Leader>gwt", require("telescope").extensions.git_worktree.create_git_worktree)
nnoremap("gwt", require("telescope").extensions.git_worktree.git_worktrees)
