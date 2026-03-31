vim.pack.add({ "https://github.com/folke/snacks.nvim" }, { confirm = false })

require("snacks").setup({
  bigfile = { enable = true },
  indent = {
    enabled = true,
    chunk = { enabled = true, only_current = true },
    indent = { enabled = false },
    scope = { enabled = true, only_current = true },
    animate = { enabled = false },
  },
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
})

vim.keymap.set("n", "<Leader>Z", function()
  Snacks.zen.zen({ toggles = { dim = false } })
end, { desc = "Toggle zen (via snacks.nvim/zen)" })

vim.keymap.set({ "n", "v" }, "<leader>go", function()
  Snacks.gitbrowse()
end, { desc = "Open a git-tracked file in a browser (via snacks.nvim/gitbrowse)" })

vim.keymap.set("n", "<Leader>.", function()
  local file = vim.fs.basename(vim.api.nvim_buf_get_name(0))
  Snacks.scratch({ name = "Scratch for " .. file })
end, { desc = "Toggle scratch buffer (via snacks.nvim/scratch)" })
