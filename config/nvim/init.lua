require("tymek")

vim.cmd("colorscheme nord")

-- TODO: create a toggleable user command from this
--[[
-- Validate HTML with https://validator.w3.org
augroup Validator
  autocmd!
  autocmd BufWritePost *.html call setqflist([], 'r', {
    \   'lines': systemlist('curl -sH "Content-Type: text/html; charset=utf-8" --data-binary @'..expand('%')..' "https://validator.w3.org/nu/?out=gnu"'),
    \   'efm': ':%l.%c-%e.%k: %t%.%#: %m'
    \ }) | cwindow
augroup END
]]--
