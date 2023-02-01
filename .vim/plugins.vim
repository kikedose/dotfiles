call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'yggdroot/indentline'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'tomarrell/vim-npr'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

call plug#end()

"PlugInstall
"PlugUpdate
"PlugStatus
"PlugClean
"PlugUpgrade
