-- Auto-instalador y autocmd para Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]]

pcall(require, 'config.notify')

return require('packer').startup(function(use)
  -- Temas
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'

  -- Mensaje elegante
  use {
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
  -- Packer se gestiona a sí mismo
  use 'wbthomason/packer.nvim'

  -- Linea de indentación
  use 'lukas-reineke/indent-blankline.nvim'

  -- Dependencias comunes
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'

  -- LSP y autocompletado
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Barra de estado
  use 'nvim-lualine/lualine.nvim'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Java LSP y debugging
  use 'mfussenegger/nvim-jdtls'

  -- Explorador de archivos
  use 'nvim-tree/nvim-tree.lua'

  -- Telescope (búsqueda fuzzy)
  use 'nvim-telescope/telescope.nvim'

  -- Utilidades
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use 'folke/which-key.nvim'
  use 'onsails/lspkind.nvim'

  -- DAP (Debug Adapter Protocol)
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'nvim-neotest/nvim-nio'  -- Dependencia obligatoria para dap-ui
  use 'theHamsta/nvim-dap-virtual-text'

  use {
  "akinsho/bufferline.nvim",
  tag = "*",
  requires = "nvim-tree/nvim-web-devicons"
}

  use {
  "folke/trouble.nvim",
  requires = "nvim-tree/nvim-web-devicons",
}

  -- Smear cursor effect
  use 'sphamba/smear-cursor.nvim'

  -- Terminal integrada
  use 'akinsho/toggleterm.nvim'

  -- Reader
  use "Sang-it/reader.nvim"

  -- Otros plugins visuales y de productividad
  use 'tzachar/local-highlight.nvim'
  use 'echasnovski/mini.animate'
  use({ 'iamcco/markdown-preview.nvim', run = 'cd app && npm install', ft = { 'markdown' } })
  use 'phaazon/hop.nvim'
  use 'sindrets/diffview.nvim'
  use 'HiPhish/rainbow-delimiters.nvim'

  -- Sincronizar plugins si es primera instalación
  if packer_bootstrap then
    require('packer').sync()
  end
end)
