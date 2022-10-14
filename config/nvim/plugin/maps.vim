let mapleader = ' '
let maplocalleader = ' '

" ^X mode
inoremap <C-f> <C-x><C-f>

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
