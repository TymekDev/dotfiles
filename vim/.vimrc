" ------------------------------------------------------------------------------
" -- Plugins
" ------------------------------------------------------------------------------
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


" ------------------------------------------------------------------------------
" -- General settings
" ------------------------------------------------------------------------------
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
set list
set listchars=tab:\|\ ,trail:˽ " Shelf character: <C-v>u02fd
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
set tags=./tags,tags;~
set textwidth=80
set wrap

set directory^=~/.vim/tmp//
set backupdir^=~/.vim/tmp//
set undodir^=~/.vim/tmp//

" Default with ruler set and a path changed an absolute one
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P


" ------------------------------------------------------------------------------
" -- Extracted from defaults.vim
" ------------------------------------------------------------------------------
set display=truncate
set history=500
set incsearch
set nolangremap
set scrolloff=5
set showcmd
set ttimeout
set ttimeoutlen=100
set wildmenu

" Moving cursor to last known position on an edit of a non-commit file
augroup CursorLastPosition
    autocmd!
    autocmd BufReadPost *
        \   if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' && &ft !~# 'diff'
        \ |     exe "normal! g`\""
        \ | endif
augroup END


" ------------------------------------------------------------------------------
" -- Coloring
" ------------------------------------------------------------------------------
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


" ------------------------------------------------------------------------------
" -- Mappings
" ------------------------------------------------------------------------------
map <Leader>l :set hlsearch!<CR>
nmap <Leader>h :set hlsearch<CR>/<C-r><C-w><CR>``

imap <C-j> <C-x><C-o>
imap <C-l> <C-x><C-n>

map <Leader>rnu :set rnu!<CR>
nmap <silent> <Leader>c :execute "set colorcolumn="
                  \ . (&colorcolumn == "" ? "+1" : "")<CR>

" Adding quotes to current word.
nmap <Leader>aq  viw<ESC>`<i"<ESC>`>la"<ESC>
nmap <Leader>asq viw<ESC>`<i'<ESC>`>la'<ESC>
nmap <Leader>agq viw<ESC>`<i`<ESC>`>la`<ESC>

" New entry in ChangeLog:
"   - assuming entry header format:
"       '<anything><version num><optional something without numbers> (DATE)',
"   - first line in the file is the entry header.
nmap <Leader>ncl gg:1co0<CR>/[0-9]\([^0-9]+\)\? (<CR><C-a>$F)"_dT(
            \"=strftime("%Y-%m-%d")<C-m>Po<ESC>O<Tab>


" ------------------------------------------------------------------------------
" -- Tabs and windows
" ------------------------------------------------------------------------------
nmap <C-n> :tabnew 

nmap <C-1> :tabnext 1<CR>
nmap <C-2> :tabnext 2<CR>
nmap <C-3> :tabnext 3<CR>
nmap <C-4> :tabnext 4<CR>
nmap <C-5> :tabnext 5<CR>
nmap <C-6> :tabnext 6<CR>
nmap <C-7> :tabnext 7<CR>
nmap <C-8> :tabnext 8<CR>
nmap <C-9> :tabnext 9<CR>
nmap <C-0> :tablast<CR>

nmap <C-h> :tabprevious<CR>
nmap <C-l> :tabnext<CR>

nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l


" ------------------------------------------------------------------------------
" -- vim-go
" ------------------------------------------------------------------------------
let g:go_fmt_command = 'goimports'

" Creates fName const for function
nmap <Leader>ef ?^package\s[A-z]*$<CR>wviw"9y''
    \0w:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \:let @9 = "const fName = \"<C-R>9\""<CR>

" Creates fName const for method
nmap <Leader>em ?^package\s[A-z]*$<CR>wviw"9y''
    \0WW:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \W:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \:let @9 = "const fName = \"<C-R>9\""<CR>

nmap <Leader>ei /{<CR>o<ESC>"9po<ESC>


" ------------------------------------------------------------------------------
" -- quick-scope
" ------------------------------------------------------------------------------
let g:qs_hi_priority = 20

nmap <Leader>q <Plug>(QuickScopeToggle)
xmap <Leader>q <Plug>(QuickScopeToggle)


" ------------------------------------------------------------------------------
" -- YouCompleteMe
" ------------------------------------------------------------------------------
nmap <Leader>j :YcmCompleter GoToDefinition<CR>
