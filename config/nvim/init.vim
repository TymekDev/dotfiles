call plug#begin()

Plug 'AndrewRadev/switch.vim'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/lexima.vim'
Plug 'itchyny/lightline.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'rust-lang/rust.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'

" Common
Plug 'nvim-lua/plenary.nvim'
Plug 'numToStr/Comment.nvim'

" Treesitter
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSInstall all'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'windwp/nvim-ts-autotag'

" LSP
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'neovim/nvim-lspconfig'

" cmp
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

call plug#end()


" ----------------------------------------------------------------------------
"  Plugin setup
" ----------------------------------------------------------------------------
" AndrewRadev/switch.vim
let g:switch_custom_definitions = [
      \   {
      \     '\<[a-z0-9]\+_\k\+\>': {
      \       '_\(.\)': '\U\1'
      \     },
      \     '\<[a-z0-9]\+[A-Z]\k\+\>': {
      \       '\([A-Z]\)': '_\l\1'
      \     },
      \   }
      \ ]


" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0


" itchyny/lightline.vim
let g:lightline = {
  \   'colorscheme': 'gruvbox_material',
  \   'inactive': {
  \     'left': [
  \       [ 'filename', 'modified' ]
  \     ]
  \   }
  \ }


" junegunn/goyo.vim
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
