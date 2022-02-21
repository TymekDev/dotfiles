let mapleader = ' '
let maplocalleader = ' '

" ^X mode
inoremap <C-f> <C-x><C-f>
inoremap <C-j> <C-x><C-o>
inoremap <C-l> <C-x><C-n>

" Splits
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l
nnoremap gf <C-w>_<C-w>\|

" Tabs
nnoremap <C-n> <Cmd>tabnew 
nnoremap <C-h> <Cmd>tabprevious<CR>
nnoremap <C-l> <Cmd>tabnext<CR>

" Quickfix List
nnoremap <C-j> <Cmd>cnext<CR>
nnoremap <C-k> <Cmd>cprev<CR>

" Misc
nmap <Leader>h <Cmd>set hlsearch!<CR>
nmap <Leader><CR> <Cmd>source $MYVIMRC<CR>

" quick-scope
nmap <Leader>q <Plug>(QuickScopeToggle)
xmap <Leader>q <Plug>(QuickScopeToggle)

" vim-easy-align
nmap <Leader>a <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)

" vim-surround
nmap <Leader>[ V<Leader>[
vmap <Leader>[ S{kJl
