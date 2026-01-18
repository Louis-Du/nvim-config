-- lua/config/dap-java.lua
-- Listeners para DAP-UI (jdtls configura DAP automáticamente)

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

-- Auto-abrir DAP-UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
