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


" cohama/lexima.vim
" See: https://github.com/cohama/lexima.vim/issues/129#issuecomment-1028725217
call lexima#add_rule({'char': '(', 'at': '\%#\S\|\S\%#'})
call lexima#add_rule({'char': '[', 'at': '\%#\S\|\S\%#'})
call lexima#add_rule({'char': '{', 'at': '\%#\S\|\S\%#'})
call lexima#add_rule({'char': '"', 'at': '\%#\S\|\S\%#'})
call lexima#add_rule({'char': "'", 'at': '\%#\S\|\S\%#'})
call lexima#add_rule({'char': '`', 'at': '\%#\S\|\S\%#'})


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
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
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
"  Lua
" ----------------------------------------------------------------------------
lua require("init")
lua require("lsp")
