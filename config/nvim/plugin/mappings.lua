vim.g.mapleader = " "

-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap
local xnoremap = require("tymek.keymap").xnoremap


-- Splits, tabs, and QuickFix list
nnoremap("<Leader>h", "<C-w>h")
nnoremap("<Leader>j", "<C-w>j")
nnoremap("<Leader>k", "<C-w>k")
nnoremap("<Leader>l", "<C-w>l")

nnoremap("<C-p>", { cmd = "tabprevious" })
nnoremap("<C-n>", { cmd = "tabnext" })

nnoremap("<C-h>", { cmd = "colder" })
nnoremap("<C-j>", { cmd = "cnext", count = true })
nnoremap("<C-k>", { cmd = "cprev", count = true })
nnoremap("<C-l>", { cmd = "cnewer" })


-- Special buffers and external commands
nnoremap("<Leader><C-e>", { cmd = "Ex" })
nnoremap("<Leader><C-g>", { cmd = "Git" })

nnoremap("<C-c>", function() vim.cmd("silent !tmux neww -c " .. vim.fn.getcwd()) end)
nnoremap("<C-s>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<C-_>", "<Cmd>silent !tmux neww tmux-cht.sh<CR>")


-- Registers
xnoremap("<Leader>p", '"_dP') -- don't overwrite paste register
nnoremap("<Leader>y", '"+y') -- copy to system register
xnoremap("<Leader>y", '"+y')


-- Toggles
nnoremap("<Leader>Q", { cmd = "QuickScopeToggle" })
nnoremap("<Leader>W", { cmd = "WiderActiveBufToggle" })
nnoremap("<Leader>T", { cmd = "Twilight" })
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
nnoremap("<Leader>ff", require("telescope.builtin").find_files) -- FIXME: does not find hidden files
nnoremap("<Leader>fg", require("telescope.builtin").live_grep)

nnoremap("<Leader>gwt", require("telescope").extensions.git_worktree.create_git_worktree)
nnoremap("gwt", require("telescope").extensions.git_worktree.git_worktrees)
