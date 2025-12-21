" Opciones básicas
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
syntax enable
set clipboard=unnamedplus
set termguicolors

let mapleader=" "

" Plugins
source ~/.config/nvim/vim/plugins.vim

" Atajos Nvim-Tree
nnoremap <leader>e :lua safe_toggle()<CR>
nnoremap <leader>r :NvimTreeFindFile<CR>
nnoremap <leader>R :NvimTreeRefresh<CR>

" Configuración Lua modular
lua require("config.cmp")
lua require("config.treesitter")
lua require("config.lsp")
lua require("config.nvimtree")   
