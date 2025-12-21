vim.call("plug#begin", "~/.local/share/nvim/plugged")

-- LSP
vim.cmd("Plug 'neovim/nvim-lspconfig'")

-- Autocompletado
vim.cmd("Plug 'hrsh7th/nvim-cmp'")
vim.cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
vim.cmd("Plug 'hrsh7th/cmp-buffer'")
vim.cmd("Plug 'hrsh7th/cmp-path'")

-- Snippets
vim.cmd("Plug 'L3MON4D3/LuaSnip'")
vim.cmd("Plug 'saadparwaiz1/cmp_luasnip'")

-- Autopairs
vim.cmd("Plug 'windwp/nvim-autopairs'")

-- Treesitter
vim.cmd("Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}")

-- File explorer
vim.cmd("Plug 'nvim-tree/nvim-tree.lua'")
vim.cmd("Plug 'nvim-tree/nvim-web-devicons'")

vim.call("plug#end")
