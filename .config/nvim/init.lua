--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- IMPORTS
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plug')      -- Plugins

-- colorscheme
vim.cmd [[colorscheme gruvbox]]

-- search highlight
vim.cmd [[set hlsearch]]
vim.cmd [[nnoremap <silent> <space> :nohlsearch<CR>]]

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- update time for gitgutter/coc/etc.
vim.cmd [[set updatetime=100]]
vim.opt.signcolumn = "yes"

vim.cmd [[set tabstop=4]]
vim.cmd [[set softtabstop=4]]
vim.cmd [[set expandtab]]
vim.cmd [[set shiftwidth=4]]

vim.cmd [[augroup filetype_py]]
vim.cmd [[
autocmd FileType python setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ expandtab
    \ autoindent
    \ fileformat=unix
"    \ textwidth=79  " automatic line wrapping
augroup end]]

vim.cmd [[augroup filetype_cpp]]
vim.cmd [[
autocmd FileType cpp setlocal
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ expandtab
    \ autoindent
    \ fileformat=unix
augroup end
]]

vim.cmd [[augroup filetype_js]]
vim.cmd [[
autocmd FileType javascript,typescript,typescriptreact setlocal
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ expandtab
    \ autoindent
    \ fileformat=unix
augroup end]]

vim.cmd [[nmap <silent> <C-k> <Plug>(ale_previous_wrap)]]
vim.cmd [[nmap <silent> <C-j> <Plug>(ale_next_wrap)]]

-- vim-slime
vim.cmd [[let g:slime_target = "tmux"]]
vim.cmd [[let g:slime_dont_ask_default = 1]]
vim.cmd [[let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}]]
vim.cmd [[vmap <A-CR> <Plug>SlimeRegionSend<Esc>`><Down>]]
vim.cmd [[nmap <A-CR> <s-v><Plug>SlimeRegionSend<Esc><Esc><Down>]]
vim.cmd [[imap <A-CR> <Esc><Esc><s-v><Plug>SlimeRegionSend<Esc><Esc><Down>i]]

vim.cmd [[set laststatus=2]]  -- Show filename at all times
vim.cmd [[set shortmess-=S]]  -- Show search count in status bar

-- Toggle pasting from clipboard
vim.cmd [[set pastetoggle=<F3>]]

-- Mouse scroll wheel moves cursor (instead of screen)
vim.cmd [[map <ScrollWheelUp> k]]
vim.cmd [[map <ScrollWheelDown> j]]

-- coc: autocomplete suggestion with Enter
vim.cmd [[inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]]
