require("repos").setup({
  callbacks = {
    ["sso"] = function(root)
      vim.opt.makeprg = "make -C " .. root
      vim.opt.shellpipe = "2>/dev/null | sed 's#^[^[:blank:]]#" .. root .. "/src/&#' | tee"
      if vim.filetype.match({ buf = 0 }) == "go" then
        vim.opt.textwidth = 0
      end
    end,
  },
})
