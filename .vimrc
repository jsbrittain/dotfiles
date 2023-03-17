set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'				" Colorscheme
Plugin 'dense-analysis/ale'				" Syntax checking
Plugin 'Valloric/YouCompleteMe'			" Code completion (requires compiling)
Plugin 'airblade/vim-gitgutter'			" Track git changes
Plugin 'preservim/nerdtree'				" File browser
Plugin 'jpalardy/vim-slime'				" Send commands using tmux
Plugin 'iamcco/markdown-preview.nvim'	" Markdown previewer

call vundle#end()            " required
filetype plugin indent on    " required

" termdebug
packadd termdebug
let g:termdebug_wide=1

" ale
let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_python_flake8_options = '--ignore=E501,W503'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1

" nerdtree
nmap ± :NERDTree<CR><C-w>l   " Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" vim-slime
let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
vmap <A-CR> <Plug>SlimeRegionSend<Esc>`><Down>
nmap <A-CR> <s-v><Plug>SlimeRegionSend<Esc><Esc><Down>
imap <A-CR> <Esc><Esc><s-v><Plug>SlimeRegionSend<Esc><Esc><Down>i
set <A-CR>=	" Alt-Enter for line execution
				" To type this in insert mode: <C-V><Alt-<something>> <C-V><M>

" YouCompleteMe keybindings
let mapleader=","
nnoremap <leader>gd :YcmCompleter GetDoc<CR>
nnoremap <leader>gtp :YcmCompleter GetType<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" A custom Python debug... insert/enable interact mode...
nmap <leader>¬ oimport code; code.interact(local=dict(globals(), **locals()))

" Enable highlight search (Space to turn off)
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Swap file directory
set directory=$HOME/.vim/swapfiles//

" Ensure backspace works everywhere, not just EOL
set backspace=indent,eol,start

" Default behaviour
syntax on
set t_Co=256
colorscheme gruvbox
set bg=dark
set foldmethod=indent
set foldlevel=99
set updatetime=100
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number           " also, 'set number relativenumber'
set colorcolumn=80   " col indicator
" Autocomplete closing brackets
inoremap {<CR> {<CR>}<C-o>O
" Add assignment (<-) and pipe (%>%) keybindings, 'similar' to RStudio
imap - <-<Space>
imap m %>%<Space>

" Start vim in insert mode
"autocmd BufRead,BufNewFile * start

" Show filename at all times
set laststatus=2

" Toggle pasting from clipboard without successive indents
set pastetoggle=<F3>

augroup filetype_py
autocmd FileType python setlocal
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

augroup filetype_js
autocmd FileType javascript,typescript,typescriptreact setlocal
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ expandtab
    \ autoindent
    \ fileformat=unix
augroup end
