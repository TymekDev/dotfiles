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

call vundle#end()
filetype plugin indent on


" [-------------------- General --------------------]
source $VIMRUNTIME/defaults.vim

colorscheme delek
let $LANG="en_US"
set encoding=utf-8
set fileencoding=utf-8

set tabstop=4
set shiftwidth=4
" set expandtab
set number
set clipboard=unnamedplus       " Share paste/yank clipboard with system | Windows: unnamed / Unix: unnamedplus
set lazyredraw                  " Fastens scrolling
set backspace=indent,eol,start  " More flexible backspace
set nohlsearch                  " Disably highlight search on startup
set splitright                  " Set vertical split to the right
set splitbelow                  " Set horizontal split to the below
set autochdir                   " Update working dir on change of split / tab
set laststatus=2                " Always display status line
set mouse=
set wrap
set textwidth=0
set spelllang=en,pl
set pastetoggle=<F2>

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


" [--------------------- Coloring --------------------]



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

" Replace trailing and all literal matches of clipboard contents
nnoremap <Leader>cr ciw<C-R>0<ESC>
nnoremap <Leader>ct :+1,$s/\V<C-R>=escape(@*, '/\')<CR>//g<Left><Left>
nnoremap <Leader>ca :%s/\V<C-R>=escape(@*, '/\')<CR>//g<Left><Left>

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

highlight QuickScopePrimary ctermfg=5
highlight QuickScopeSecondary ctermfg=6


" [--------------------- vim-sneak --------------------]
map <Leader>s <Plug>Sneak_s
map <Leader>S <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

highlight Sneak ctermfg=8 ctermbg=0


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
