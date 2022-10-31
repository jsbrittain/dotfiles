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
Plugin 'morhetz/gruvbox'           " Colorscheme
Plugin 'preservim/nerdtree'        " File browser

Plugin 'preservim/vimux'           " Interact with tmux
Plugin 'greghor/vim-pyShell'       " Improved interactivity with ipython
Plugin 'julienr/vim-cellmode'      " Block execution

Plugin 'jalvesaq/Nvim-R'           " R-interactive session

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

nnoremap <space> za
imap <F5> <Esc><F5>
nmap <F5> :w<CR>:!clear;python %<CR>
imap § <C-x><C-o>

" ipython-shell
noremap ,ss :call StartPyShell()<CR>
noremap ,sk :call StopPyShell()<CR>

" code execution
nnoremap ,l :call PyShellSendLine()<CR><CR>
noremap <silent> <C-n> :call RunTmuxPythonCell(0)<CR>
noremap <C-a> :call RunTmuxPythonAllCellsAbove()<CR>

let g:ale_linters = {'python': ['flake8']}
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 1

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
