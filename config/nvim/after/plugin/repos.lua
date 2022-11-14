require("repos").setup({
  callbacks = {
    ["sso"] = function(root)
      vim.opt.makeprg = "make -C " .. root
      vim.opt.shellpipe = "2>/dev/null | sed 's#^[^[:blank:]]#" .. root .. "/src/&#' | tee"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.opt_local.textwidth = 0
        end,
      })
    end,
  },
})
