-- Formateo automático al guardar usando LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    -- Formatea solo si hay LSP activo para el buffer
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if #clients > 0 then
      vim.lsp.buf.format({
        async = false,
        timeout_ms = 2000,
      })
    end
  end,
})
