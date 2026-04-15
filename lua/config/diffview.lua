-- Configuración para diffview.nvim
require('diffview').setup({})

-- Keymaps recomendados para abrir/cerrar Diffview
vim.keymap.set('n', '<leader>gd', ":DiffviewOpen<CR>", { desc = "Abrir Diffview" })
vim.keymap.set('n', '<leader>gq', ":DiffviewClose<CR>", { desc = "Cerrar Diffview" })
