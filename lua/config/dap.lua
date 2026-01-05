-- lua/config/dap.lua
local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup()
  require("nvim-dap-virtual-text").setup()

  dap.listeners.after.event_initialized["dapui"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui"] = function()
    dapui.close()
  end
end

return M
