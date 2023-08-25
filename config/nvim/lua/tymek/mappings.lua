-- Mappings overview
--   g + h/j/k/l           - splits
--   Ctrl + n/p            - tabs
--   Ctrl + h/j/k/l        - quickfix list
--   g + <any>             - LSP stuff
--   <Leader> + f + <any>  - Telescope
--   <Leader> + h + <any>  - Harpoon
-- TODO: add git mappings (next/prev hunk, stage hunk)
-- TODO: add diagnostics jump mappings (vim.diagnostic.goto_*)

local M = {}

M.setup = function()
  -- Splits
  vim.keymap.set({ "n", "x" }, "gh", "<C-w>h")
  vim.keymap.set({ "n", "x" }, "gj", "<C-w>j")
  vim.keymap.set({ "n", "x" }, "gk", "<C-w>k")
  vim.keymap.set({ "n", "x" }, "gl", "<C-w>l")


  -- Tabs
  vim.keymap.set({ "n", "x" }, "<C-p>", vim.cmd.tabprevious)
  vim.keymap.set({ "n", "x" }, "<C-n>", vim.cmd.tabnext)


  -- Screen
  vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz") -- Half a screen up with center on cursor
  vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz") -- Half a screen down with center on cursor
  vim.keymap.set({ "n", "x" }, "<C-b>", "<NOP>")


  -- Search Results
  vim.keymap.set({ "n", "x" }, "n", "nzzzv") -- Next search result, center on cursor, and open folds
  vim.keymap.set({ "n", "x" }, "N", "Nzzzv") -- Previous search result, center on cursor, and open folds


  -- Quickfix list
  vim.keymap.set({ "n", "x" }, "<C-h>", function() -- Previous quickfix list with opening if non-empty
    vim.cmd.colder({ count = vim.api.nvim_eval("v:count1") })
    vim.cmd.cwindow()
  end)
  vim.keymap.set({ "n", "x" }, "<C-j>", function() -- Next quickfix entry with wrapping and opening if non-empty
    local ok, msg = pcall(vim.cmd.cnext, { count = vim.api.nvim_eval("v:count1") })
    if ok == false and msg == "Vim:E553: No more items" then
      vim.cmd.cfirst()
    end
    vim.cmd.cwindow()
  end)
  vim.keymap.set({ "n", "x" }, "<C-k>", function() -- Previous quickfix entry with wrapping and opening if non-empty
    local ok, msg = pcall(vim.cmd.cprev, { count = vim.api.nvim_eval("v:count1") })
    if ok == false and msg == "Vim:E553: No more items" then
      vim.cmd.clast()
    end
    vim.cmd.cwindow()
  end)
  vim.keymap.set({ "n", "x" }, "<C-l>", function() -- Next quickfix list with opening if non-empty
    vim.cmd.cnewer({ count = vim.api.nvim_eval("v:count1") })
    vim.cmd.cwindow()
  end)


  -- Registers
  vim.keymap.set("x", "<Leader>p", '"_dP')         -- Don't overwrite paste register
  vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y') -- Use system register
  vim.keymap.set({ "n", "x" }, "<Leader>Y", '"+Y')
  vim.keymap.set({ "n", "x" }, "<Leader>d", '"+d')
  vim.keymap.set({ "n", "x" }, "<Leader>D", '"+D')


  -- Toggles
  vim.keymap.set({ "n", "x" }, "<Leader>Q", "<Cmd>QuickScopeToggle<CR>")
  vim.keymap.set({ "n", "x" }, "<Leader>W", "<Cmd>WiderActiveBufToggle<CR>")
  vim.keymap.set({ "n", "x" }, "<Leader>R", function() vim.o.relativenumber = not vim.o.relativenumber end)
  vim.keymap.set({ "n", "x" }, "<Leader>S", function() vim.opt_local.spell = not vim.opt_local.spell:get() end)


  -- Spelling
  vim.keymap.set("n", "zf", "]s1z=") -- Fix next bad word with first suggestion
  vim.keymap.set("n", "zF", "[s1z=") -- Fix previous bad word with first suggestion


  -- Miscellaneous
  vim.keymap.set({ "n", "x" }, "<C-s>", "<Cmd>silent !tmux run-shell tmux-sessionizer<CR>")
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])


  -- Commands opening an entire buffer
  vim.keymap.set({ "n", "x" }, "<Leader><C-e>", "<Cmd>Ex<CR>")
  vim.keymap.set({ "n", "x" }, "<Leader><C-g>", "<Cmd>Git<CR>")


  -- junegunn/vim-easy-align
  vim.keymap.set({ "n", "x" }, "<Leader>a", "<Plug>(EasyAlign)")


  -- nvim-telescope/telescope.nvim
  vim.keymap.set({ "n", "x", "i" }, "<C-f>", require("telescope.builtin").find_files)       -- [f]iles
  vim.keymap.set({ "n", "x", "i" }, "<C-g>", require("telescope.builtin").live_grep)        -- [g]rep
  vim.keymap.set({ "n", "x" }, "<Leader>fc", require("telescope.builtin").commands)         -- [c]ommands
  vim.keymap.set({ "n", "x" }, "<Leader>fch", require("telescope.builtin").command_history) -- [c]ommand [h]istory
  vim.keymap.set({ "n", "x" }, "<Leader>fh", require("telescope.builtin").help_tags)        -- [h]elp
  vim.keymap.set({ "n", "x" }, "<Leader>fq", require("telescope.builtin").quickfix)         -- [q]uickfix
  vim.keymap.set({ "n", "x" }, "<Leader>fe", function()                                     -- [e]xplore (:Ex)
    require("telescope").extensions.file_browser.file_browser({ cwd = "%:p:h" })
  end)


  -- ThePrimeagen/harpoon
  vim.keymap.set({ "n", "x" }, "<Leader>hm", require("harpoon.ui").toggle_quick_menu)
  vim.keymap.set({ "n", "x" }, "<Leader>ha", require("harpoon.mark").add_file)
  vim.keymap.set({ "n", "x" }, "<Leader>h1", function() require("harpoon.ui").nav_file(1) end)
  vim.keymap.set({ "n", "x" }, "<Leader>h2", function() require("harpoon.ui").nav_file(2) end)
  vim.keymap.set({ "n", "x" }, "<Leader>h3", function() require("harpoon.ui").nav_file(3) end)
  vim.keymap.set({ "n", "x" }, "<Leader>h4", function() require("harpoon.ui").nav_file(4) end)


  -- hrsh7th/nvim-cmp
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


  -- DAP
  vim.keymap.set("n", "<Leader>dc", require("dap").continue)


  -- TODO: sort this out
  vim.keymap.set({ "n", "x" }, "<Leader>go", require("tymek.git").open)
  vim.keymap.set("n", "<Leader>gp", require("gitsigns").prev_hunk)
  vim.keymap.set("n", "<Leader>gn", require("gitsigns").next_hunk)
  -- vim.keymap.set({ "n", "x" }, "gj", vim.diagnostic.goto_next)
  -- vim.keymap.set({ "n", "x" }, "gk", vim.diagnostic.goto_prev)

  -- <leader>dn next
  -- <leader>di in
  -- <leader>do out

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
  -- Special buffers and external commands

  -- TODO: move to on_attach
  M.lsp()
end

M.lsp = function()
  vim.keymap.set("n", "K", vim.lsp.buf.hover)
  vim.keymap.set("n", "gK", vim.diagnostic.open_float)
  vim.keymap.set("n", "<Leader>K", vim.lsp.buf.signature_help)

  vim.keymap.set("n", "gd", vim.lsp.buf.definition)       -- [d]efinition
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)  -- [t]ype definition
  vim.keymap.set("n", "gr", vim.lsp.buf.rename)           -- [r]ename
  vim.keymap.set("n", "gca", vim.lsp.buf.code_action)     -- [c]ode [a]ction

  vim.keymap.set("n", "gqd", vim.diagnostic.setqflist)    -- [d]iagnostics
  vim.keymap.set("n", "gqi", vim.lsp.buf.implementation)  -- [i]mplementation
  vim.keymap.set("n", "gqr", vim.lsp.buf.references)      -- [r]eferences
  vim.keymap.set("n", "gqs", vim.lsp.buf.document_symbol) -- [s]ybmol

  vim.keymap.set("n", "<Leader>fd", require("telescope.builtin").diagnostics)
  vim.keymap.set("n", "<Leader>fi", require("telescope.builtin").lsp_implementations)
  vim.keymap.set("n", "<Leader>fr", require("telescope.builtin").lsp_references)
  vim.keymap.set("n", "<Leader>fw", require("telescope.builtin").lsp_dynamic_workspace_symbols)
  vim.keymap.set("n", "<Leader>fs", function()
    require("telescope.builtin").lsp_document_symbols({ symbol_width = 50 })
  end)
end

return M
