---@module "lazy"
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<C-f>", "<Cmd>Telescope find_files<CR>", desc = "Find files (via telescope.nvim)" },
    { "<C-g>", "<Cmd>Telescope live_grep<CR>", desc = "Live grep (via telescope.nvim)" },
    {
      "<Leader><C-f>",
      function()
        local get_current_dir = require("telescope.utils").buffer_dir
        if vim.bo[0].filetype == "oil" then
          get_current_dir = require("oil").get_current_dir
        end
        require("telescope.builtin").find_files({
          cwd = get_current_dir(),
        })
      end,
      desc = "Find files in the buffer's directory (via telescope.nvim)",
    },
    { "<Leader><C-g>", "<Cmd>Telescope grep_string<CR>", desc = "Live grep a string (via telescope.nvim)" },
    {
      "<Leader>-",
      function()
        require("telescope.builtin").find_files({
          find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
        })
      end,
      desc = "Find directories (via telescope.nvim)",
    },
    {
      "<Leader>fb",
      "<Cmd>Telescope current_buffer_fuzzy_find<CR>",
      desc = "Fuzzy find within the current buffer (via telescope.nvim)",
    },
    {
      "<Leader>ff",
      "<Cmd>Telescope resume<CR>",
      desc = "Open and restore the previously viewed picker (via telescope.nvim)",
    },
    { "<Leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Search through help tags (via telescope.nvim)" },
    { "<Leader>fq", "<Cmd>Telescope quickfix<CR>", desc = "Search through the quickfix list (via telescope.nvim)" },
    {
      "<Leader>fd",
      "<Cmd>Telescope diagnostics<CR>",
      desc = "Search through diagnostics (via telescope.nvim)",
    },
    {
      "<Leader>fi",
      "<Cmd>Telescope lsp_implementations<CR>",
      desc = "Search through implementations (via telescope.nvim)",
    },
    {
      "<Leader>fr",
      "<Cmd>Telescope lsp_references<CR>",
      desc = "Search through references (via telescope.nvim)",
    },
    {
      "<Leader>fw",
      "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      desc = "Search through dynamic workspace symbols (via telescope.nvim)",
    },
    {
      "<Leader>fs",
      "<Cmd>Telescope lsp_document_symbols symbol_width=50<CR>",
      desc = "Search through documenet symbols (via telescope.nvim)",
    },
  },
  opts = function()
    return {
      defaults = {
        mappings = {
          i = {
            ["<C-f>"] = false,
            ["<M-a>"] = require("telescope.actions").toggle_all,
          },
          n = {
            ["<C-f>"] = false,
            ["<M-a>"] = require("telescope.actions").toggle_all,
          },
        },
      },
    }
  end,
}
