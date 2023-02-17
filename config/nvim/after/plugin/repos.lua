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

      vim.keymap.set({ "n", "x" }, "<Leader>go", function()
        require("tymek.git").open({ "", "labs", "master" })
      end)
    end,
  },
})
