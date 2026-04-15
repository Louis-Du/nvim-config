-- Configuración para markdown-preview.nvim
-- No requiere setup en Lua, pero puedes abrir la vista previa con :MarkdownPreview
-- Opcional: autocmd para abrir preview automáticamente
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.cmd([[nnoremap <buffer> <leader>mp :MarkdownPreview<CR>]])
  end,
})
