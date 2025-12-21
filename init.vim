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

" Telescope - búsqueda rápida
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fs :Telescope lsp_document_symbols<CR>

" Configuración Lua modular
lua require("config.cmp")
lua require("config.treesitter")
lua require("config.lsp")
lua require("config.nvimtree")   
lua require("config.autopairs")
lua require("config.comment")
lua require("config.format")
lua require("config.telescope")
