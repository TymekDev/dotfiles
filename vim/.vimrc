" [-------------------- Plugins --------------------]
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'fatih/vim-go'                       " Go IDE
Plugin 'godlygeek/tabular'                  " Required by vim-markdown
Plugin 'plasticboy/vim-markdown'            " Text coloring for markdown
Plugin 'tyru/caw.vim'                       " Commenting and uncommenting text
Plugin 'jeffkreeftmeijer/vim-numbertoggle'  " Turns on relative line numbers
Plugin 'ycm-core/YouCompleteMe'             " Syntax completion
Plugin 'unblevable/quick-scope'             " Unique letters in line highlight
Plugin 'tpope/vim-repeat'                   " Allows repeating vim-sneak movements

call vundle#end()
filetype plugin indent on


" [-------------------- General --------------------]
let $LANG="en_US"
set encoding=utf-8
set fileencoding=utf-8

set autochdir
set backspace=indent,eol,start
set clipboard=unnamedplus " Windows: unnamed / Unix: unnamedplus
set colorcolumn=+1
set expandtab
set formatoptions+=j
set laststatus=2
set lazyredraw
set mouse=
set nohlsearch
set number
set pastetoggle=<F2>
set shiftwidth=2
set showbreak=+++
set spelllang=en,pl
set splitbelow
set splitright
set tabstop=2
set textwidth=80
set wrap

" Useful settings from defaults.vim
set display=truncate
set history=500
set incsearch
set nolangremap
set scrolloff=5
set showcmd
set ttimeout
set ttimeoutlen=100
set wildmenu

" Set temp directories
set directory^=~/.vim/tmp//
set backupdir^=~/.vim/tmp//
set undodir^=~/.vim/tmp//

" Set tags search path
set tags=./tags,tags;~

" Add character for trailing spaces at lines ends and tabs
" Shelf character: <C-v>u02fd
set list
set listchars=tab:\|\ ,trail:˽

" Moving cursor to last known position on an edit of a non-commit file
augroup CursorLastPosition
    autocmd!
    autocmd BufReadPost *
        \   if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' && &ft !~# 'diff'
        \ |     exe "normal! g`\""
        \ | endif
augroup END


" [--------------------- Coloring --------------------]
syntax on

function! CustomHighlights() abort
    hi QuickScopePrimary    ctermfg=magenta
    hi QuickScopeSecondary  ctermfg=darkcyan
    hi ColorColumn          ctermbg=darkgray
endfunction

function! ColorSchemeOverride() abort
    hi Identifier ctermfg=cyan
endfunction

augroup ApplyHighlights
    autocmd!
    autocmd ColorScheme * call CustomHighlights()
                      \ | call ColorSchemeOverride()
augroup END

colorscheme delek


" [-------------------- Status line --------------------]
" Default with ruler set and a path changed an absolute one
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P


" [-------------------- Keybinds --------------------]
noremap <Leader>l :set hlsearch!<CR>
nnoremap <Leader>h :set hlsearch<CR>/<C-r><C-w><CR>``

inoremap <C-j> <C-x><C-o>
inoremap <C-l> <C-x><C-n>

noremap <Leader>rnu :set rnu!<CR>
nnoremap <silent> <Leader>c :execute "set colorcolumn="
                  \ . (&colorcolumn == "" ? "+1" : "")<CR>





" [-------------------- Other --------------------]
" Adding quotes to current word.
nnoremap <Leader>aq  viw<ESC>`<i"<ESC>`>la"<ESC>
nnoremap <Leader>asq viw<ESC>`<i'<ESC>`>la'<ESC>
nnoremap <Leader>agq viw<ESC>`<i`<ESC>`>la`<ESC>

" New entry in ChangeLog:
"   - assuming entry header format:
"       '<anything><version num><optional something without numbers> (DATE)',
"   - first line in the file is the entry header.
nnoremap <Leader>ncl gg:1co0<CR>/[0-9]\([^0-9]+\)\? (<CR><C-a>$F)"_dT(
            \"=strftime("%Y-%m-%d")<C-m>Po<ESC>O<Tab>


" [-------------------- Go --------------------]
let g:go_fmt_command = 'goimports'

" Creates fName const for function
nnoremap <Leader>ef ?^package\s[A-z]*$<CR>wviw"9y''
    \0w:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \:let @9 = "const fName = \"<C-R>9\""<CR>

" Creates fName const for method
nnoremap <Leader>em ?^package\s[A-z]*$<CR>wviw"9y''
    \0WW:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \W:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \:let @9 = "const fName = \"<C-R>9\""<CR>

nnoremap <Leader>ei /{<CR>o<ESC>"9po<ESC>


" [--------------------- quick-scope --------------------]
let g:qs_hi_priority = 20

nmap <Leader>q <Plug>(QuickScopeToggle)
xmap <Leader>q <Plug>(QuickScopeToggle)


" [--------------------- YouCompleteMe --------------------]
nnoremap <Leader>j :YcmCompleter GoToDefinition<CR>
