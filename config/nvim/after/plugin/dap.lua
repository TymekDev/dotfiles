require("dapui").setup()
require("dap-go").setup()
require("nvim-dap-virtual-text").setup({})
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
