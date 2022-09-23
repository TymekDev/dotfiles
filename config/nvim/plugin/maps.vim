let mapleader = ' '
let maplocalleader = ' '

" ^X mode
inoremap <C-f> <C-x><C-f>
inoremap <C-j> <C-x><C-o>
inoremap <C-l> <C-x><C-n>

" Tabs
nnoremap <C-n> :tabnew 

" Misc
nmap <Leader>h <Cmd>set hlsearch!<CR>
nmap <Leader><CR> <Cmd>source $MYVIMRC<CR>
nnoremap <silent> <C-s> <Cmd>silent !tmux neww tmux-sessionizer<CR>
nnoremap <silent> <C-_> <Cmd>silent !tmux neww tmux-cht.sh<CR>

nnoremap <expr> J 'mz' .. v:count1 .. 'J`z'
" nnoremap <Leader>j :m .+1<CR>==
" nnoremap <Leader>k :m .-2<CR>==
vnoremap <Leader>j :m '>+1<CR>gv=gv
vnoremap <Leader>k :m '<-2<CR>gv=gv

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

" vim-surround
nmap <Leader>[ V<Leader>[
vmap <Leader>[ S{kJl
