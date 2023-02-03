syntax on

set fileformat=unix
set encoding=UTF-8

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab
set nowrap
set list
set listchars=eol:.,tab:>-,trail:~,extends:>,precedes:<

set cursorline
set number
set relativenumber
set scrolloff=8
set signcolumn=yes
set showcmd
set noshowmode
set conceallevel=1
set shortmess+=c
set formatoptions-=cro

set noerrorbells visualbell t_vb=
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamed
set updatetime=300

set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <CR> :noh<CR><CR>:<backspace>
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim
so ~/.vim/autoclose.vim

" Disable automatic comment
autocmd FileType * setlocal formatoptions-=cro

" Rust ?
filetype plugin indent on

"-- COLOR & THEME CONFIG
set termguicolors
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE
let g:terminal_ansi_colors = [
    \ '#282828', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#a89984',
    \ '#928374', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2',
\]
