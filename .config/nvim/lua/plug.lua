-- [[ plug.lua ]]

local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
  local use = use
  -- add you plugins here like:
  -- use 'neovim/nvim-lspconfig'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',  -- fuzzy finder
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'majutsushi/tagbar' }                        -- code structure
  use { 'Yggdroot/indentLine' }                      -- see indentation
  use { 'tpope/vim-fugitive' }                       -- git integration
  use { 'junegunn/gv.vim' }                          -- commit history (':GV')
  use { 'windwp/nvim-autopairs' }                    -- auto close brackets, etc.
  use { "ellisonleao/gruvbox.nvim" }                 -- colorscheme
  use { "github/copilot.vim" }                       -- copilot
  use { 'airblade/vim-gitgutter' }			         -- track git changes
  use { 'dense-analysis/ale' }				         -- Syntax checking
  use { 'neoclide/coc.nvim', branch = 'release'}     -- LSP
  use { 'preservim/nerdtree' }				         -- File browser
  use { 'jpalardy/vim-slime' }				         -- Send commands using tmux
  use { 'iamcco/markdown-preview.nvim' }	         -- Markdown previewer
  use { 'snakemake/snakemake', rtp='misc/vim', ft='snakemake' }  -- Snakemake syntax
  use { 'christoomey/vim-tmux-navigator' }	         -- Navigate between tmux and vim
  use { 'preservim/tagbar' }                         -- Code structure (tagbar)
  -- RUST
  use 'williamboman/mason.nvim'    
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig' 
  use 'simrat39/rust-tools.nvim'
  use 'hrsh7th/nvim-cmp'                            -- Completion framework:
  use 'hrsh7th/cmp-nvim-lsp'                        -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lua'                        -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'
  use 'nvim-treesitter/nvim-treesitter'
  use 'puremourning/vimspector'
  end
)
