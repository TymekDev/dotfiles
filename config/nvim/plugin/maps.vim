let mapleader = ' '
let maplocalleader = ' '

" ^X mode
inoremap <C-f> <C-x><C-f>
inoremap <C-j> <C-x><C-o>
inoremap <C-l> <C-x><C-n>

" Tabs
nnoremap <C-n> :tabnew 

" Misc
nnoremap <silent> <C-s> <Cmd>silent !tmux neww tmux-sessionizer<CR>
nnoremap <silent> <C-_> <Cmd>silent !tmux neww tmux-cht.sh<CR>

nnoremap <expr> J 'mz' .. v:count1 .. 'J`z'
" nnoremap <Leader>j :m .+1<CR>==
" nnoremap <Leader>k :m .-2<CR>==
vnoremap <Leader>j :m '>+1<CR>gv=gv
vnoremap <Leader>k :m '<-2<CR>gv=gv

" vim-easy-align
nmap <Leader>a <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)

" vim-surround
nmap <Leader>[ V<Leader>[
vmap <Leader>[ S{kJl
