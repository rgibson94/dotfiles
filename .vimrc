call plug#begin()
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'wincent/command-t'
Plug 'jlanzarotta/bufexplorer'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/gv.vim'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'sirver/ultisnips'
Plug 'thinca/vim-quickrun'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-latex/vim-latex'
Plug 'matze/vim-move'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

filetype plugin on

set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
"let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
	  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

try
    colorscheme badwolf
catch
endtry

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

syntax enable

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

set expandtab
set smarttab
set shiftwidth=3
set tabstop=3

set number
set cursorline
set lazyredraw

set incsearch
set hlsearch
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" jk is escape
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>


set ai
set si
set wrap

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>
nmap <leader>q :wq<cr>

nmap <leader>f :Files<cr>

nmap <leader>n :NERDTreeToggle<cr>

nmap <C-n> :NERDTreeToggle<CR>

set ruler
