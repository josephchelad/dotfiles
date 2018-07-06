" Enable Syntax Colouring
if !exists("g:syntax_on")
    syntax enable
endif

" Visual spaces per tab
set tabstop=4

" Lazy redraw
set lazyredraw

" Matching parenthesis
set showmatch

" Searching options
set incsearch  " Incremental Search
set ignorecase " Case insensitive Comparison
set smartcase  " Unless using Capitals
set hlsearch   " Highlight matches

" Enable Bottom ruler
set ruler

" Normal Backspace behaviour
set backspace=indent,eol,start
