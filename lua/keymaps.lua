-- Leader key
vim.g.mapleader = " "

-- Explorador de archivos
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Debug

vp.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

vim.keymap.set("n", "<leader>dd", function()
  require("config.dap").setup()
end, { desc = "Start DAP" })

