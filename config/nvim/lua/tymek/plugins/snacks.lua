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
        Snacks.zen.zen({ toggles = { dim = false } })
      end,
      desc = "Toggle zen (via snacks.nvim/zen)",
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
      what = "permalink",
      remote_patterns = {
        -- stylua: ignore start
        { "^(https?://.*)%.git$",               "%1" },
        { "^git@(.+):(.+)%.git$",               "https://%1/%2" },
        { "^git@(.+):(.+)$",                    "https://%1/%2" },
        { "^git@(.+)/(.+)$",                    "https://%1/%2" },
        { "^ssh://git@(.*)$",                   "https://%1" },
        { "^ssh://([^:/]+)(:%d+)/(.*)$",        "https://%1/%3" },
        { "^ssh://([^/]+)/(.*)$",               "https://%1/%2" },
        { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
        { "^https://%w*@(.*)",                  "https://%1" },
        { "^git@(.*)",                          "https://%1" },
        { ":%d+",                               "" },
        { "%.git$",                             "" },
        { "/scm/(.*)/(.*)$",                    "/projects/%1/repos/%2" },
        -- stylua: ignore end
      },
      url_patterns = {
        ["sourcecode%..*%.com"] = {
          file = "/browse/{file}?at=refs%2Fheads%2F{branch}#{line_start}-{line_end}",
        },
        ["codeberg%.org"] = {
          branch = "/src/branch/{branch}",
          file = "/src/branch/{branch}/{file}#L{line_start}-L{line_end}",
          permalink = "/src/commit/{commit}/{file}#L{line_start}-L{line_end}",
          commit = "/commit/{commit}",
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
