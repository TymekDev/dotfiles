" [-------------------- Plugins --------------------]
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'fatih/vim-go'                       " Go IDE
Plugin 'godlygeek/tabular'                  " Required by vim-markdown
Plugin 'plasticboy/vim-markdown'            " Text coloring for markdown
Plugin 'francoiscabrol/ranger.vim'          " Add support for ranger as directory viewer
Plugin 'rbgrouleff/bclose.vim'              " Required by ranger.vim
Plugin 'tyru/caw.vim'                       " Commenting and uncommenting text
Plugin 'jeffkreeftmeijer/vim-numbertoggle'  " Turns on relative line numbers
Plugin 'ycm-core/YouCompleteMe'             " Syntax completion
Plugin 'unblevable/quick-scope'             " Unique letters in line highlight
Plugin 'justinmk/vim-sneak'                 " Quick movement to characters between lines
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
" Line character: <C-v>u23b8
" Shelf character: <C-v>u02fd
set list
set listchars=tab:⎸\ ,trail:˽

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
    hi Sneak                ctermfg=darkgray ctermbg=black
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

nnoremap <Enter> o<ESC>
nnoremap <S-Enter> O<ESC>

nnoremap <C-n> :tabnew<CR>
nnoremap 0gt :tablast<CR>

noremap <Leader>rnu :set rnu!<CR>
nnoremap <silent> <Leader>c :execute "set colorcolumn="
                  \ . (&colorcolumn == "" ? "+1" : "")<CR>


" [-------------------- Window size adjustments --------------------]
nmap <Leader>nm :vertical res 85<CR>
nmap <Leader>rl :vertical res +10<CR>
nmap <Leader>rh :vertical res -10<CR>
nmap <Leader>rk :res +10<CR>
nmap <Leader>rj :res -10<CR>


" [-------------------- Replacements --------------------]
" Find, replace word, replace trailing and replace all words, respectively
nnoremap <Leader>wr :s/<C-R><C-W>//g<Left><Left>
nnoremap <Leader>wt :+1,$s/<C-R><C-W>//g<Left><Left>
nnoremap <Leader>wa :%s/<C-R><C-W>//g<Left><Left>

" Replace current match, trailing matches and all matches of selection
" Info:
"   "9y                     yanks selection to selected 'clipboard' number 9
"   \V                      stands for literal (no regex)
"   =escape(@9, '/\')<CR>   returns escaped string from 'clipboard' number 9
vnoremap <Leader>vr "9y :s/\V<C-R>=escape(@9, '/\')<CR>//g<Left><Left>
vnoremap <Leader>vt "9y :+1,$s/\V<C-R>=escape(@9, '/\')<CR>//g<Left><Left>
vnoremap <Leader>va "9y :%s/\V<C-R>=escape(@9, '/\')<CR>//g<Left><Left>

nnoremap <Leader>uf mu:call UnicodeFlatten()<CR>`u
nnoremap <Leader>ue mu:call UnicodeExpand()<CR>`u


" [-------------------- Other --------------------]
" Adding quotes to current word.
nnoremap <Leader>aq  viw<ESC>`<i"<ESC>`>la"<ESC>
nnoremap <Leader>asq viw<ESC>`<i'<ESC>`>la'<ESC>
nnoremap <Leader>agq viw<ESC>`<i`<ESC>`>la`<ESC>

" Adding quotes to selection.
vnoremap <Leader>aq  <ESC>`<i"<ESC>`>la"<ESC>
vnoremap <Leader>asq <ESC>`<i'<ESC>`>la'<ESC>
vnoremap <Leader>agq <ESC>`<i`<ESC>`>la`<ESC>

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


" [--------------------- Ranger --------------------]
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1


" [--------------------- quick-scope --------------------]
let g:qs_hi_priority = 20

nmap <Leader>q <Plug>(QuickScopeToggle)
xmap <Leader>q <Plug>(QuickScopeToggle)


" [--------------------- vim-sneak --------------------]
map <Leader>s <Plug>Sneak_s
map <Leader>S <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


" [--------------------- YouCompleteMe --------------------]
nnoremap <Leader>j :YcmCompleter GoToDefinition<CR>


" [-------------------- Functions --------------------]
" Functions substitutes polish diacritic signs with their ASCII equivalents
function! UnicodeFlatten()
    for r in [["u0105", "a"], ["u0107", "c"], ["u0119", "e"], ["u0142", "l"],
             \["u0144", "n"], ["u00F3", "o"], ["u015B", "s"], ["u017C", "z"],
             \["u017A", "z"], ["u0104", "A"], ["u0106", "C"], ["u0118", "E"],
             \["u0141", "L"], ["u0143", "N"], ["u00D3", "O"], ["u015A", "S"],
             \["u017B", "Z"], ["u0179", "Z"]]
        silent! execute ":s/\\%" . r[0] . "/" . r[1] . "/g"
    endfor
endfunction

" Functions substitutes polish diacritic signs with their UTF-8 codes
function! UnicodeExpand()
    for r in ["u0105", "u0107", "u0119", "u0142", "u0144", "u00F3",
             \"u015B", "u017C", "u017A", "u0104", "u0106", "u0118",
             \"u0141", "u0143", "u00D3", "u015A", "u017B", "u0179"]
        silent! execute ":s/\\%" . r . "/\\\\" . r . "/g"
    endfor
endfunction
