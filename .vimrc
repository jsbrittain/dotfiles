set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'dense-analysis/ale'        " 
Plugin 'nvie/vim-flake8'           " PEP8 style guides (links to Flake)
Plugin 'davidhalter/jedi-vim'      " 
Plugin 'airblade/vim-gitgutter'    " Track git changes

Plugin 'morhetz/gruvbox'           " Colorscheme
Plugin 'preservim/nerdtree'        " File browser
Plugin 'jpalardy/vim-slime'        " Send commands using tmux [configured below] by <C-c><C-c>
Plugin 'jalvesaq/Nvim-R'           " R-interactive session (.R files only)

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
set t_Co=256
" colorscheme atom-dark-256
colorscheme gruvbox
set bg=dark
set foldmethod=indent
set foldlevel=99
set updatetime=100

imap <F5> <Esc><F5>
nmap <F5> :w<CR>:!clear;python %<CR>
imap § <C-x><C-o>

set <A-CR>= " To type this in insert mode: <C-V><Alt-<something>> <C-V><M>
vmap <A-CR> <Plug>SlimeRegionSend<Esc>`><Down>
nmap <A-CR> <s-v><Plug>SlimeRegionSend<Esc><Esc><Down>
imap <A-CR> <Esc><Esc><s-v><Plug>SlimeRegionSend<Esc><Esc><Down>i

let g:ale_linters = {'python': ['flake8']}
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = "2"
let g:slime_target = "tmux"

let g:slime_dont_ask_default = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" Remove underscore for assignment (<-), replace with Alt- (like RStudio)
let R_assign = 0
imap - <-<Space>
imap m %>%<Space>

set tabstop=4
set softtabstop=4
set shiftwidth=4

au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

"match ErrorMsg '\%>80v.\+'
set number " set number relativenumber, for relative line numbers
set colorcolumn=80

" Exit Vim if NERDTree is the only window remaining in the only tab.
nmap ± :NERDTree<CR><C-w>l
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
