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

-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

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

vim.cmd [[let g:ale_python_flake8_options = '--ignore=W503,E203 --max-line-length=88']]

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
"    \ textwidth=88  " automatic line wrapping
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
vim.cmd [[imap <ScrollWheelUp> <Up>]]
vim.cmd [[imap <ScrollWheelDown> <Down>]]

-- coc: autocomplete suggestion with Enter
vim.cmd [[inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]]

vim.cmd [[set conceallevel=0]]

vim.cmd [[set nofoldenable]]

vim.cmd [[let g:ale_linters = {'python': ['flake8'], 'c++': ['clang'], 'javascript': ['eslint']}]]

-- R files: override to 80 characters
vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})
