-- FIXME: colors opening nvim with live_grep are off

-- NOTE: git_commits, git_bcommits, and grep_curbuf seem useful.

---@module "lazy"
---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-g>", "<Cmd>FzfLua live_grep<CR>", desc = "Live grep (via fzf-lua)" },
    { mode = "v", "<C-g>", "<Cmd>FzfLua grep_visual<CR>", desc = "Grep visual selection (via fzf-lua)" },
    {
      "<Leader><C-g>",
      function()
        ---@type string|nil
        local current_dir = vim.fn.expand("%:p:h")
        if vim.bo[0].filetype == "oil" then
          current_dir = require("oil").get_current_dir()
        end
        require("fzf-lua").live_grep({
          cwd = current_dir,
        })
      end,
      desc = "Live grep in the buffer's directory (via telescope.nvim)",
    },
  },
  opts = function()
    local actions = require("fzf-lua.actions")
    return {
      actions = {
        files = {
          true,
          ["ctrl-s"] = false,
          ["ctrl-x"] = actions.file_split,
          ["ctrl-q"] = {
            fn = actions.buf_sel_to_qf,
            prefix = "select-all+",
          },
        },
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --no-require-git -e",
      },
    }
  end,
}
