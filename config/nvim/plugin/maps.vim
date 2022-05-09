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
nnoremap <C-n> :tabnew 
nnoremap <C-h> <Cmd>tabprevious<CR>
nnoremap <C-l> <Cmd>tabnext<CR>

" Quickfix List
nnoremap <C-j> <Cmd>cnext<CR>
nnoremap <C-k> <Cmd>cprev<CR>

" Misc
nmap <Leader>h <Cmd>set hlsearch!<CR>
nmap <Leader><CR> <Cmd>source $MYVIMRC<CR>
nnoremap <silent> <C-s> <Cmd>silent !tmux neww tmux-sessionizer<CR>
nnoremap <silent> <C-_> <Cmd>silent !tmux neww tmux-cht.sh<CR>

nnoremap <expr> J 'mz' .. v:count1 .. 'J`z'
nnoremap <Leader>j :m .+1<CR>==
nnoremap <Leader>k :m .-2<CR>==
vnoremap <Leader>j :m '>+1<CR>gv=gv
vnoremap <Leader>k :m '<-2<CR>gv=gv

" Yanking and pasting
nmap <Leader>y "+y
nmap <Leader><Leader>y <Cmd>%y+<CR>

" goyo.vim
nnoremap <Leader>G <Cmd>Goyo<CR>

" fzf.vim
nnoremap <C-p> <Cmd>GFiles<CR>
nnoremap <Leader><C-p> <Cmd>Files<CR>
nnoremap <Leader><C-o> <Cmd>Rg<CR>

" quick-scope
nmap <Leader>q <Plug>(QuickScopeToggle)
xmap <Leader>q <Plug>(QuickScopeToggle)

" vim-easy-align
nmap <Leader>a <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)

" vim-fugitive
nmap <C-g> <Cmd>Git<CR>
nmap <Leader>gf <Cmd>Git fetch<CR>
nmap <Leader>gp <Cmd>Git push<CR>

" vim-surround
nmap <Leader>[ V<Leader>[
vmap <Leader>[ S{kJl
