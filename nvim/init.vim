call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'

" Neovim exclusive
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()


" ----------------------------------------------------------------------------
"  Plugin setup
" ----------------------------------------------------------------------------
" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0


" fatih/vim-go
let g:go_fmt_command = 'goimports'


" itchyny/lightline.vim
let g:lightline = {
  \   'colorscheme': 'gruvbox_material',
  \   'inactive': {
  \     'left': [
  \       [ 'filename', 'modified' ]
  \     ]
  \   }
  \ }


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
"  Lua
" ----------------------------------------------------------------------------
lua require("init")
