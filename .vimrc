set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'        " Syntax checking
Plugin 'Valloric/YouCompleteMe'    " Code completion (requires compiling)
Plugin 'airblade/vim-gitgutter'    " Track git changes
Plugin 'morhetz/gruvbox'           " Colorscheme
Plugin 'preservim/nerdtree'        " File browser
Plugin 'jpalardy/vim-slime'        " Send commands using tmux [configured below] by <C-c><C-c>

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set t_Co=256
colorscheme gruvbox
set bg=dark
set foldmethod=indent
set foldlevel=99
set updatetime=100

imap <F5> <Esc><F5>
nmap <F5> :w<CR>:!clear;python %<CR>

" Slime keybindings, Alt-Enter for line execution
set <A-CR>= " To type this in insert mode: <C-V><Alt-<something>> <C-V><M>
vmap <A-CR> <Plug>SlimeRegionSend<Esc>`><Down>
nmap <A-CR> <s-v><Plug>SlimeRegionSend<Esc><Esc><Down>
imap <A-CR> <Esc><Esc><s-v><Plug>SlimeRegionSend<Esc><Esc><Down>i

let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

let g:ale_linters = {'python': ['flake8']}
let g:ycm_autoclose_preview_window_after_insertion = 1

" Add assignment (<-) and pipe (%>%) keybindings, 'similar' to RStudio
imap - <-<Space>
imap m %>%<Space>

" YouCompleteMe keybindings
let mapleader=","
nnoremap <leader>gd :YcmCompleter GetDoc<CR>
nnoremap <leader>gtp :YcmCompleter GetType<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Autocomplete closing brackets
inoremap {<CR> {<CR>}<C-o>O

" Default behaviour
set tabstop=4
set softtabstop=4
set shiftwidth=4

augroup filetype_py
autocmd FileType py setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix
augroup end

augroup filetype_cpp
autocmd FileType cpp setlocal
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix
augroup end

set number           " also, 'set number relativenumber'
set colorcolumn=80   " col indicator

" Exit Vim if NERDTree is the only window remaining in the only tab.
nmap ± :NERDTree<CR><C-w>l
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
