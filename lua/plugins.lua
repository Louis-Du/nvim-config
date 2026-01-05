vim.schedule(function()
  if vim.g.is_termux then
    vim.notify("Neovim en Termux 🟢", vim.log.levels.INFO)
  else
    vim.notify("Neovim en Fedora 🟣", vim.log.levels.INFO)
  end
end)

vim.call("plug#begin", "~/.local/share/nvim/plugged")

-- ===== CORE (ambos) =====

-- LSP base (solo cliente)
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

-- Explorador
vim.cmd("Plug 'nvim-tree/nvim-tree.lua'")
vim.cmd("Plug 'nvim-tree/nvim-web-devicons'")

-- ===== SOLO FEDORA =====
if not vim.g.is_termux then
  vim.cmd("Plug 'williamboman/mason.nvim'")
  vim.cmd("Plug 'williamboman/mason-lspconfig.nvim'")
end

vim.call("plug#end")
