" # 4 space tabs, new lines will be auto-indented and curly braces will be aligned automatically 
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab

autocmd BufNewFile,BufRead *.date set filetype=date
autocmd FileType date inoremap <cr> <cr>[<c-r>=strftime("%e-%b-%Y %T")<cr>]

" # Enable line numbers at startup
set number

" # Show file path and name at startup
set laststatus=2
set statusline+=%F\ %l\:%c

" # Line move commands
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv


" # Highlight search (to remove highlight, do `:noh`.
" # The highlight will return for next search
set hlsearch

" # Show tabs
set listchars=tab:>-,trail:<
set list

" # Set color scheme to "darkblue"
colorscheme desert

