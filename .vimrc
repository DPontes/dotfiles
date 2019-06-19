" # 4 space tabs, new lines will be auto-indented and curly braces will be aligned automatically
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" # Enable line numbers at startup
set number

" # Show file path and name at startup
set laststatus=2
set statusline+=%F\ %l\:%c

" # Highlight search (to remove highlight, do `:noh`.
" # The highlight will return for next search
set hlsearch

" # Show tabs
set listchars=tab:>-,trail:<
set list

" # Set color scheme to "slate"
colorscheme desert
