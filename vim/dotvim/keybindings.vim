nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

nmap <silent> <leader>xml :%!xmllint --format -<CR>
nmap <silent> <leader>json :%!python -m json.tool<CR>
nmap <silent> <leader>lint :ALEFix<CR>

" Fix common annoyances
inoremap jk <esc>
nnoremap <c-c> <esc>
noremap <Tab> <C-w>w
noremap <F1> <Esc>
noremap Z zz

" Mappings for IO operations
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
noremap <leader>r :redraw!<cr>

" Search current word
noremap <leader>ag :Ag <c-r>=expand("<cword>")<cr><Enter>

" Clear search highlights
noremap <silent><leader>/ :nohls<CR>

" Bjarke!
nnoremap <tab><tab>r :!open "http://www.youtube.com/watch?v=Eky6bCnCLOI\#t=171"<cr>

" Remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\vecho (\$.{-});/if(isset(\1)) echo \1;/g<Bar>:let @/=_s<Bar>:nohl<CR>

" Use 'h', 'j', 'k' and 'l' to nagivate splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open splits with leader
noremap <leader>vs :vs %<cr>
noremap <leader>ss :split %<cr>

" Use '-' and '+' to resize window
noremap - <C-W><
noremap + <C-W>>
noremap <A-j> <C-W>-
noremap <A-k> <C-W>+

" Bring up fzf, for opening files
noremap <leader>f :FZF<CR>

source ~/.vim/dotvim/buffers.vim
