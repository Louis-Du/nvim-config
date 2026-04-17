local is_termux = (os.getenv('PREFIX') or ''):find('com.termux')
if not is_termux then
	local ok, diffview = pcall(require, 'diffview')
	if ok then
		diffview.setup({})
	end
end

vim.keymap.set('n', '<leader>gd', ":DiffviewOpen<CR>", { desc = "Abrir Diffview" })
vim.keymap.set('n', '<leader>gq', ":DiffviewClose<CR>", { desc = "Cerrar Diffview" })

