-- Configuración para hop.nvim
require('hop').setup()

-- Keymaps recomendados para saltos rápidos
vim.keymap.set('n', '<leader>hw', ":HopWord<CR>", { desc = "Hop a palabra" })
vim.keymap.set('n', '<leader>hl', ":HopLine<CR>", { desc = "Hop a línea" })
vim.keymap.set('n', '<leader>hc', ":HopChar1<CR>", { desc = "Hop a caracter" })
