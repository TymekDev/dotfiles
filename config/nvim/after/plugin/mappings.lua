-- TODO: move to which-key.nvim
vim.g.mapleader = " "

-- NOTE: there are also LSP-specifc mappings inside lua/tymek/lsp/init.lua
local nnoremap = require("tymek.keymap").nnoremap
local xnoremap = require("tymek.keymap").xnoremap


vim.keymap.set("n", "<Leader>h", "<C-w>h")
vim.keymap.set("n", "<Leader>j", "<C-w>j")
vim.keymap.set("n", "<Leader>k", "<C-w>k")
vim.keymap.set("n", "<Leader>l", "<C-w>l")

vim.keymap.set({ "n", "x" }, "<C-p>", vim.cmd.tabprevious)
vim.keymap.set({ "n", "x" }, "<C-n>", vim.cmd.tabnext)

vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz") -- Half screen up and center on cursor
vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz") -- Half screen down and center on cursor

vim.keymap.set("n", "n", "nzzzv")                -- Next search result, center on cursor, and open folds
vim.keymap.set("n", "N", "Nzzzv")                -- Previous search result, center on cursor, and open folds

vim.keymap.set("n", "<C-h>", function()          -- Previous quickfix list
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

vim.keymap.set({ "n", "x" }, "<C-b>", "<NOP>")
vim.keymap.set({ "n", "x" }, "<C-s>", "<Cmd>silent !tmux run-shell tmux-sessionizer<CR>")

vim.keymap.set({ "n", "x" }, "<Leader>go", require("tymek.git").open)


-- Registers
xnoremap("<Leader>p", '"_dP') -- don't overwrite paste register
nnoremap("<Leader>y", '"+y')  -- copy to system register
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

vim.keymap.set("n", "<Leader>t", ":t.<Left><Left>")
vim.keymap.set("n", "<Leader>m", ":m.<Left><Left>")

-- TODO: make these work with count (jump & fix N times) and .
vim.keymap.set("n", "zf", "]s1z=") -- Fix next bad word with first suggestion
vim.keymap.set("n", "zF", "[s1z=") -- Fix previous bad word with first suggestion


-- Telescope
nnoremap("<Leader>fq", require("telescope.builtin").quickfix)                                                       -- [q]uickfix
nnoremap("<Leader>fe", function() require("telescope").extensions.file_browser.file_browser({ cwd = "%:p:h" }) end) -- [e]xplore (:Ex)
vim.keymap.set({ "n", "x" }, "<C-f>", require("telescope.builtin").find_files)                                      -- [f]iles
vim.keymap.set({ "n", "x" }, "<C-g>", require("telescope.builtin").live_grep)                                       -- [g]rep
nnoremap("<Leader>fh", require("telescope.builtin").help_tags)                                                      -- [h]elp
nnoremap("<Leader>fc", require("telescope.builtin").commands)                                                       -- [c]ommands
nnoremap("<Leader>fch", require("telescope.builtin").command_history)                                               -- [c]ommand history
nnoremap("<Leader>fb", require("telescope.builtin").current_buffer_fuzzy_find)                                      -- [b]uffer


-- TODO: refactor using which-key.nvim
local function git(args)
  return function()
    require("plenary.job"):new({ command = "git", args = args }):start()
  end
end

vim.keymap.set("n", "<Leader>Gl", git({ "pull" }))
vim.keymap.set("n", "<Leader>Gp", git({ "push" }))
vim.keymap.set("n", "<Leader>gp", require("gitsigns").prev_hunk)
vim.keymap.set("n", "<Leader>gn", require("gitsigns").next_hunk)


vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])


-- TODO: clean these up, possibly make them nop
nnoremap("K", vim.lsp.buf.hover) -- FIXME: this breaks links in :help
nnoremap("gd", vim.lsp.buf.definition)
nnoremap("gt", vim.lsp.buf.type_definition)
nnoremap("gr", vim.lsp.buf.rename)
nnoremap("gK", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>K", vim.lsp.buf.signature_help)
nnoremap("gca", vim.lsp.buf.code_action)

nnoremap("gqd", vim.diagnostic.setqflist)    -- [d]iagnostics
nnoremap("gqi", vim.lsp.buf.implementation)  -- [i]mplementation
nnoremap("gqr", vim.lsp.buf.references)      -- [r]eferences
nnoremap("gqs", vim.lsp.buf.document_symbol) -- [s]ybmol

-- gn/gp + gk vs gj/gk + gK
vim.keymap.set({ "n", "x" }, "gj", vim.diagnostic.goto_next)
vim.keymap.set({ "n", "x" }, "gk", vim.diagnostic.goto_prev)

vim.keymap.set("n", "<Leader>gd", function()
  vim.cmd.vsplit()
  vim.lsp.buf.definition()
end)
vim.keymap.set("n", "<Leader>gt", function()
  vim.cmd.vsplit()
  vim.lsp.buf.type_definition()
end)

nnoremap("<Leader>fd", require("telescope.builtin").diagnostics)
nnoremap("<Leader>fi", require("telescope.builtin").lsp_implementations)
nnoremap("<Leader>fr", require("telescope.builtin").lsp_references)
nnoremap("<Leader>fs", require("telescope.builtin").lsp_document_symbols)
nnoremap("<Leader>fw", require("telescope.builtin").lsp_dynamic_workspace_symbols)


vim.keymap.set({ "i", "c" }, "<C-j>", require("cmp").mapping.complete())
require("cmp").setup({
  mapping = {
    ["<C-e>"] = require("cmp").mapping({
      i = require("cmp").mapping.abort(),
      c = require("cmp").mapping.close(),
    }),
    ["<C-u>"] = require("cmp").mapping(require("cmp").mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = require("cmp").mapping(require("cmp").mapping.scroll_docs(4), { "i", "c" }),
    ["<C-n>"] = require("cmp").mapping(require("cmp").mapping.select_next_item(), { "i", "c" }),
    ["<C-p>"] = require("cmp").mapping(require("cmp").mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = require("cmp").mapping(require("cmp").mapping.confirm({ select = true }), { "i", "c" }),
  },
})

-- TODO: sort this out
--
-- <leader>dn next
-- <leader>di in
-- <leader>do out

-- local dap, dapui = require("dap"), require("dapui")
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- require("dap").continue()
-- require("dap").toggle_breakpoint()
-- step_into
-- step_over
-- step_out
-- set_breakpoint(vim.fn.input("Breakpoint condition: "))
-- ? run_last

-- require("dapui").toggle()
-- eval()
-- ? disable dap console
-- make splits bigger

-- require("dap-go").debug_test()
-- ? debug_last_test()
