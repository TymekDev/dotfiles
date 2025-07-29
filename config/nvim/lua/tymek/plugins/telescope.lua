-- NOTE: <C-l> in LSP mappings autocompletes filtering.

-- NOTE: the variable has to be declared beforehand. Otherwise, the mapping doesn't find the find_files function.
local find_files
find_files = function(opts)
  opts = opts or {}

  opts.find_command = { "rg", "--files", "--color", "never", "--no-require-git" }

  opts.prompt_title = "Find Files"
  if opts.hidden then
    opts.prompt_title = opts.prompt_title .. " (hidden: true)"
  end

  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<M-d>", function(_prompt_bufnr)
      local filename = require("telescope.actions.state").get_selected_entry()[1]
      require("telescope.actions").close(_prompt_bufnr)
      require("oil").open(vim.fs.dirname(filename))
    end)

    map({ "n", "i" }, "<C-h>", function(_prompt_bufnr)
      local prompt = require("telescope.actions.state").get_current_line()
      require("telescope.actions").close(_prompt_bufnr)
      find_files(vim.tbl_extend("force", opts, {
        default_text = prompt,
        hidden = not opts.hidden,
      }))
    end)

    return true
  end

  require("telescope.builtin").find_files(opts)
end

---@module "lazy"
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<C-f>", find_files, desc = "Find files (via telescope.nvim)" },
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
    {
      "<Leader>-",
      function()
        require("telescope.builtin").find_files({
          find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git", "--exclude", ".jj" },
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
    {
      ft = "r",
      "<M-s>",
      '<Cmd>Telescope lsp_document_symbols symbols="string"<CR>',
      desc = "Search through file's sections (via telescope.nvim)",
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
