call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'cohama/lexima.vim'
Plug 'itchyny/lightline.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'sainnhe/gruvbox-material'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'

" Neovim exclusive
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'windwp/nvim-ts-autotag'

call plug#end()


" ----------------------------------------------------------------------------
"  Plugin setup
" ----------------------------------------------------------------------------
" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0


" cohama/lexima.vim
" See: https://github.com/cohama/lexima.vim/issues/129#issuecomment-1028725217
call lexima#add_rule({'char': '(', 'at': '\%#\S\{-1,})'})
call lexima#add_rule({'char': '[', 'at': '\%#\S\{-1,}]'})
call lexima#add_rule({'char': '{', 'at': '\%#\S\{-1,}}'})
call lexima#add_rule({'char': '"', 'at': '"\S\{-1,}\%#\|\%#\S\{-1,}"'})
call lexima#add_rule({'char': "'", 'at': "'\S\{-1,}\%#\|\%#\S\{-1,}'"})
call lexima#add_rule({'char': '`', 'at': '`\S\{-1,}\%#\|\%#\S\{-1,}`'})


" itchyny/lightline.vim
let g:lightline = {
  \   'colorscheme': 'gruvbox_material',
  \   'inactive': {
  \     'left': [
  \       [ 'filename', 'modified' ]
  \     ]
  \   }
  \ }


" Plug 'junegunn/goyo.vim'
let g:goyo_width = 85
let g:goyo_linenr = 1

function! s:goyo_enter()
  Limelight
endfunction

function! s:goyo_leave()
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" sainnhe/gruvbox-material
let g:gruvbox_material_diagnostic_line_highlight = 1
if has('termguicolors')
  set termguicolors
endif
colorscheme gruvbox-material
syntax on


" unblevable/quick-scope
let g:qs_hi_priority = 20
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


" ----------------------------------------------------------------------------
"  Other
" ----------------------------------------------------------------------------
" Validate HTML with https://validator.w3.org
augroup Validator
  autocmd!
  autocmd BufWritePost *.html call setqflist([], 'r', {
    \   'lines': systemlist('curl -sH "Content-Type: text/html; charset=utf-8" --data-binary @'..expand('%')..' "https://validator.w3.org/nu/?out=gnu"'),
    \   'efm': ':%l.%c-%e.%k: %t%.%#: %m'
    \ }) | cwindow
augroup END


" ----------------------------------------------------------------------------
"  Lua
" ----------------------------------------------------------------------------
lua require("init")
lua require("lsp")
