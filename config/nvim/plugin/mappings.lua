vim.g.mapleader = " "

-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap
local xnoremap = require("tymek.keymap").xnoremap


-- Splits, tabs, and QuickFix list
nnoremap("<Leader>h", "<C-w>h")
nnoremap("<Leader>j", "<C-w>j")
nnoremap("<Leader>k", "<C-w>k")
nnoremap("<Leader>l", "<C-w>l")

nnoremap("<Leader><C-x>", { cmd = "new" })
nnoremap("<Leader><C-v>", { cmd = "vnew" })
nnoremap("<Leader><C-n>", { cmd = "tabnew" })
nnoremap("<C-p>", { cmd = "tabprevious" })
nnoremap("<C-n>", { cmd = "tabnext" })

nnoremap("<C-h>", { cmd = "colder" })
nnoremap("<C-j>", { cmd = "cnext", count = true })
nnoremap("<C-k>", { cmd = "cprev", count = true })
nnoremap("<C-l>", { cmd = "cnewer" })


-- Special buffers and external commands
nnoremap("<Leader><C-e>", { cmd = "Ex" })
nnoremap("<Leader><C-g>", { cmd = "Git" })

nnoremap("<C-s>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<C-_>", "<Cmd>silent !tmux neww tmux-cht.sh<CR>")


-- Registers
xnoremap("<Leader>p", '"_dP') -- don't overwrite paste register
nnoremap("<Leader>y", '"+y') -- copy to system register
xnoremap("<Leader>y", '"+y')


-- Toggles
nnoremap("<Leader>Q", { cmd = "QuickScopeToggle" })
nnoremap("<Leader>W", { cmd = "WiderActiveBufToggle" })
nnoremap("<Leader>R", function() vim.o.relativenumber = not vim.o.relativenumber end)
nnoremap("<Leader>T", { cmd = "Twilight" })
nnoremap("<Leader>P", { cmd = "PlainMode" })
nnoremap("<Leader>Z", { cmd = "ZenMode" })


-- Editing
xnoremap("<C-j>", ":m '>+1<CR>gv=gv") -- move selection up and reindent
xnoremap("<C-k>", ":m '<-2<CR>gv=gv") -- move selection down and reindent

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
