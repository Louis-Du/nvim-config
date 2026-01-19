-- Formateo automático al guardar usando LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    -- Formatea solo si hay LSP activo para el buffer
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if #clients > 0 then
      local ok, err = pcall(vim.lsp.buf.format, {
        async = false,
        timeout_ms = 5000,
      })
      if not ok then
        vim.notify("Format error: " .. tostring(err), vim.log.levels.WARN)
      end
    end
  end,
})
