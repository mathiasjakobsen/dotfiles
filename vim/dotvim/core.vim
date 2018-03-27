let mapleader = ","                         " Use ',' as leader
set nocompatible                            " Must come first because it changes other options.
set timeout timeoutlen=1000 ttimeoutlen=100 " Faster <ESC>

syntax enable                               " Turn on syntax highlighting
filetype plugin indent on                   " Turn on file type detection

set showcmd                                 " Display incomplete commands
set showmode                                " Display the mode you're in
set pastetoggle=<F2>
set backspace=indent,eol,start              " Intuitive backspacing
set hidden                                  " Handle multiple buffers better
set wildmenu                                " Enhanced command line completion
set wildmode=list:longest                   " Complete files like a shell
set ignorecase                              " Case-insensitive searching
set smartcase                               " But case-sensitive if expression contains a capital letter
set number                                  " Show line numbers
set ruler                                   " Show cursor position
set incsearch                               " Highlight matches as you type
set hlsearch                                " Highlight matches
set nofoldenable                            " Disable folding
set wrap                                    " Turn on line wrapping
set scrolloff=6                             " Show 3 lines of context around the cursor.
set showmatch
set title                                   " Set the terminal's title
set visualbell                              " No beeping
set noeb vb t_vb=                           " Stop the god damn beeps!
set nobackup                                " Don't make a backup before overwriting a file
set nowritebackup                           " And again
set noswapfile                              " Don't make swapfiles
set backupskip=/tmp/*,/private/tmp/*
set undodir=~/.vim/undo
set expandtab                               " Use spaces instead of tabs
set tabstop=2                               " <Tab> == 2 spaces
set shiftwidth=2
set backspace=2
set smarttab
set laststatus=2                            " Always show the status line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set autoindent                              " Indent at the same level as previous line
set smartindent
set shortmess=a                             " Avoid 'Hit ENTER to continue'
set list
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•


highlight ColorColumn ctermbg=yellow
call matchadd('ColorColumn', '\%81v', 100)


set autoread " Auto read buffer, if changes were made to current file
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END
