-- lua/config/dap-java.lua
-- Configuración específica de DAP para Java (JDTLS)
-- Los listeners de dapui están centralizados en config/dap.lua

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("nvim-dap not found", vim.log.levels.WARN)
  return
end

-- Configurar DAP para usar consola interna de DAP-UI
dap.configurations.java = {
  {
    type = 'java',
    request = 'launch',
    name = "Launch Java Program",
    console = 'internalConsole',
  },
}
