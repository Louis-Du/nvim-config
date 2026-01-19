-- lua/config/dap-java.lua
-- Configuración REAL de DAP para Java (JDTLS)

local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify("jdtls not found", vim.log.levels.WARN)
  return
end

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("nvim-dap not found", vim.log.levels.WARN)
  return
end

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
  vim.notify("dapui not found", vim.log.levels.WARN)
  return
end

-- 🔥 CONFIGURAR DAP PARA USAR CONSOLA DE DAP-UI
dap.configurations.java = {
  {
    type = 'java',
    request = 'launch',
    name = "Launch Java Program",
    console = 'console',  -- Usar consola de DAP-UI (panel inferior)
  },
}

-- UI automática con notificaciones
dap.listeners.after.event_initialized["dapui_java"] = function()
  dapui.open()
  vim.notify("✓ Debugger started", vim.log.levels.INFO)
end

dap.listeners.before.event_terminated["dapui_java"] = function()
  dapui.close()
  vim.notify("✗ Debugger terminated", vim.log.levels.WARN)
end

dap.listeners.before.event_exited["dapui_java"] = function()
  dapui.close()
  vim.notify("✗ Debugger exited", vim.log.levels.WARN)
end
