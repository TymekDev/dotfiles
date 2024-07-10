---@module "lazy"
---@type LazySpec
return {
  "tpope/vim-fugitive",
  cmd = "Git",
  keys = {
    { "<Leader>gf", "<Cmd>Git fetch<CR>", ft = "fugitive", desc = "Run `git fetch` (via vim-fugitive)" },
    { "<Leader>gl", "<Cmd>Git pull<CR>", ft = "fugitive", desc = "Run `git pull` (via vim-fugitive)" },
    { "<Leader>gp", "<Cmd>Git push<CR>", ft = "fugitive", desc = "Run `git push` (via vim-fugitive)" },
    {
      "<Leader>gP",
      "<Cmd>Git push --force-with-lease<CR>",
      ft = "fugitive",
      desc = "Run `git push --force-with-lease` (via vim-fugitive)",
    },
  },
}
