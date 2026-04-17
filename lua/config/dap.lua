-- lua/config/dap.lua
local M = {}

function M.setup()
  local dap_ok, dap = pcall(require, "dap")
  if not dap_ok then 
    vim.notify("nvim-dap not found", vim.log.levels.ERROR)
    return 
  end

  local dapui_ok, dapui = pcall(require, "dapui")
  if not dapui_ok then 
    vim.notify("dapui not found", vim.log.levels.ERROR)
    return 
  end

  local virtual_text_ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
  if not virtual_text_ok then
    vim.notify("nvim-dap-virtual-text not found", vim.log.levels.WARN)
  else
    virtual_text.setup()
  end

  -- Configurar DAP-UI con layouts minimalistas y completos
  dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      -- Layout 1: Vista MINIMALISTA (solo console)
      {
        elements = {
          { id = "console", size = 1.0 },
        },
        size = 0.25,
        position = "bottom",
      },
      -- Layout 2: Vista COMPLETA (todos los paneles)
      {
        elements = {
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
    },
    floating = {
      max_height = nil,
      max_width = nil,
      border = "single",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil,
      max_value_lines = 100,
    }
  })

  -- Variable para trackear el estado de vista
  M.full_view = false

  -- Función para alternar entre vista simple y completa
  M.toggle_full_view = function()
    if M.full_view then
      -- Cerrar panel izquierdo, dejar solo console
      dapui.close(2)
      M.full_view = false
      vim.notify("Debug: Vista minimalista", vim.log.levels.INFO)
    else
      -- Abrir todos los paneles
      dapui.open()
      M.full_view = true
      vim.notify("Debug: Vista completa", vim.log.levels.INFO)
    end
  end

  -- Abrir SOLO console al iniciar (vista minimalista)
  dap.listeners.after.event_initialized["dapui_auto_open"] = function()
    dapui.open(1)  -- Solo abrir layout 1 (console)
    M.full_view = false
  end

  dap.listeners.before.event_terminated["dapui_auto_close_terminate"] = function()
    dapui.close()
    M.full_view = false
  end

  dap.listeners.before.event_exited["dapui_auto_close_exit"] = function()
    dapui.close()
    M.full_view = false
  end

  -- Signos para breakpoints (con fallback ASCII)
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })
  vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#ffae00' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })
  vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
  vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#ff0000' })
  
  vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DapBreakpoint', linehl='', numhl='' })
  vim.fn.sign_define('DapBreakpointCondition', { text='◆', texthl='DapBreakpointCondition', linehl='', numhl='' })
  vim.fn.sign_define('DapLogPoint', { text='◉', texthl='DapLogPoint', linehl='', numhl='' })
  vim.fn.sign_define('DapStopped', { text='▶', texthl='DapStopped', linehl='', numhl='' })
  vim.fn.sign_define('DapBreakpointRejected', { text='✖', texthl='DapBreakpointRejected', linehl='', numhl='' })
end

return M
