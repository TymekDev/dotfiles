" [-------------------- Plugins --------------------]
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'ervandew/supertab'
Plugin 'preservim/nerdtree'
Plugin 'hashivim/vim-terraform'

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
set expandtab
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
set textwidth=80

" Set temp directories
set directory^=~/.vim/tmp//
set backupdir^=~/.vim/tmp//
set undodir^=~/.vim/tmp//


" [--------------------- Coloring --------------------]
highlight OverLength ctermbg=yellow ctermfg=black
highlight ToDo ctermbg=gray ctermfg=black

augroup vimrc_autocmds
    autocmd!
    " 81st sign (but not a newline)
    autocmd BufEnter,WinEnter * call matchadd('OverLength', '\%81v.', 100)
    " Matching TODOs: 'TODO:', 'TODO(...):'
    autocmd BufEnter,WinEnter * call matchadd('ToDo', 'TODO\(([^ ]*)\)\?:', 99)
augroup END


" [-------------------- Status line --------------------]
" Default with ruler set and a path changed an absolute one
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P


" [-------------------- Keybinds --------------------]
noremap <C-x>l :set hlsearch!<CR>
nnoremap ,h :set hlsearch<CR>/<C-r><C-w><CR>``
nnoremap <C-n>t :NERDTree<CR>

inoremap <C-j> <C-x><C-o>
inoremap <C-l> <C-x><C-n>

nnoremap <Enter> o<ESC>
nnoremap <S-Enter> O<ESC>

nnoremap <C-n> :tabnew<CR>
nnoremap 0gt :tablast<CR>


" [-------------------- Window size adjustments --------------------]
nmap ,nm :vertical res 85<CR>
nmap nm :vertical res +10<CR>
nmap mn :vertical res -10<CR>
nmap rt :res +10<CR>
nmap tr :res -10<CR>


" [-------------------- Replacements --------------------]
" Find, replace word, replace trailing and replace all words, respectively
nnoremap ,wr :s/<C-R><C-W>//g<Left><Left>
nnoremap ,wt :+1,$s/<C-R><C-W>//g<Left><Left>
nnoremap ,wa :%s/<C-R><C-W>//g<Left><Left>

" Replace current match, trailing matches and all matches of selection
" Info:
"   "9y                     yanks selection to selected 'clipboard' number 9
"   \V                      stands for literal (no regex) 
"   =escape(@9, '/\')<CR>   returns escaped string from 'clipboard' number 9
vnoremap ,vr "9y :s/\V<C-R>=escape(@9, '/\')<CR>//g<Left><Left>
vnoremap ,vt "9y :+1,$s/\V<C-R>=escape(@9, '/\')<CR>//g<Left><Left>
vnoremap ,va "9y :%s/\V<C-R>=escape(@9, '/\')<CR>//g<Left><Left>

" Replace trailing and all literal matches of clipboard contents
nnoremap ,cr ciw<C-R>0<ESC>
nnoremap ,ct :+1,$s/\V<C-R>=escape(@*, '/\')<CR>//g<Left><Left>
nnoremap ,ca :%s/\V<C-R>=escape(@*, '/\')<CR>//g<Left><Left>

nnoremap ,uf mu:call UnicodeFlatten()<CR>`u
nnoremap ,ue mu:call UnicodeExpand()<CR>`u


" [-------------------- Other --------------------]
" Adding quotes to current word.
nnoremap ,aq  viw<ESC>`<i"<ESC>`>la"<ESC>
nnoremap ,asq viw<ESC>`<i'<ESC>`>la'<ESC>
nnoremap ,agq viw<ESC>`<i`<ESC>`>la`<ESC>

" Adding quotes to selection.
vnoremap ,aq  <ESC>`<i"<ESC>`>la"<ESC>
vnoremap ,asq <ESC>`<i'<ESC>`>la'<ESC>
vnoremap ,agq <ESC>`<i`<ESC>`>la`<ESC>

" New entry in ChangeLog:
"   - assuming entry header format:
"       '<anything><version num><optional something without numbers> (DATE)',
"   - first line in the file is the entry header.
nnoremap ,ncl ggyyP/[0-9]\([^0-9]+\)\? (<CR><C-a>$F)dT(
            \"=strftime("%Y-%m-%d")<C-m>Po<ESC>O<Tab>


" [-------------------- Markdown --------------------]
" Color markdown italic and bold
hi htmlItalic ctermfg=79
hi htmlBold ctermfg=70


" [-------------------- Go --------------------]
" Golang Autoformatting
let g:go_fmt_command = 'goimports'

" Creates fName const for function
nnoremap ,ef ?^package\s[A-z]*$<CR>wviw"9y''
    \0w:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \:let @9 = "const fName = \"<C-R>9\""<CR>

" Creates fName const for method
nnoremap ,em ?^package\s[A-z]*$<CR>wviw"9y''
    \0WW:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \W:let @9 = "<C-R>9.<C-R><C-W>"<CR>
    \:let @9 = "const fName = \"<C-R>9\""<CR>

nnoremap ,ei /{<CR>o<ESC>"9po<ESC>

:let @f = ",ef,ei"
:let @m = ",em,ei"	


" [-------------------- Terraform --------------------]
let g:terraform_align=1
let g:terraform_fmt_on_save=1


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
