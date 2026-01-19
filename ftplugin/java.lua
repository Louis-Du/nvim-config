-- ftplugin/java.lua
-- Configuración adicional específica para archivos Java
-- La inicialización de JDTLS se maneja en lua/config/lsp.lua

local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  vim.notify("jdtls not found", vim.log.levels.WARN)
  return
end

-- Solo definir keymaps de prueba unitaria si JDTLS está conectado
local opts = { noremap = true, silent = true, buffer = 0 }
if jdtls then
  vim.keymap.set('n', '<leader>dn', function() jdtls.test_nearest_method() end, opts)
  vim.keymap.set('n', '<leader>dt', function() jdtls.test_class() end, opts)
end
