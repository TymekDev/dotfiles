---@module "lazy"
---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle zoom (via snacks.nvim/zen)",
    },
    {
      mode = { "n", "v" },
      "<leader>go",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Open a git-tracked file in a browser (via snacks.nvim/gitbrowse)",
    },
    {
      "<Leader>.",
      function()
        local file = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        Snacks.scratch({ name = "Scratch for " .. file })
      end,
      desc = "Toggle scratch buffer (via snacks.nvim/scratch)",
    },
  },
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true, animate = { enabled = false } },
    gitbrowse = {
      remote_patterns = {
        { "^https://(sourcecode%..*%.com)/scm/(.*)/(.*)%.git$", "https://%1/projects/%2/repos/%3" },
        { "^https://(sourcecode%..*%.com)/scm/(.*)/(.*)$", "https://%1/projects/%2/repos/%3" },
      },
      url_patterns = {
        ["sourcecode%..*%.com"] = {
          file = "/browse/{file}?at=refs%2Fheads%2F{branch}#{line_start}-{line_end}",
        },
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  end,
}
