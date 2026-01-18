-- core/keymaps.lua - Keymaps principales de Neovim

local map = vim.keymap.set

-- ============================================================
-- Telescope
-- ============================================================
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Buscar archivos" })

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Buscar texto" })

map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Buffers abiertos" })

map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "Símbolos LSP" })

-- ============================================================
-- NvimTree
-- ============================================================
map("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Explorador archivos" })

-- Volver a nvim-tree (foco) desde cualquier ventana
map("n", "<leader>o", function()
  require("nvim-tree.api").tree.focus()
end, { desc = "Enfocar nvim-tree" })

map("n", "<leader>r", ":NvimTreeFindFile<CR>", { desc = "Encontrar archivo" })
map("n", "<leader>R", ":NvimTreeRefresh<CR>", { desc = "Refrescar árbol" })

-- Navegación entre ventanas (alternativa)
map("n", "<C-h>", "<C-w>h", { desc = "Ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ventana abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ventana arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Ventana derecha" })

-- ============================================================
-- Trouble (diagnósticos) con compatibilidad de versiones
-- ============================================================
local function trouble_cmd(cmd_new, cmd_legacy)
  -- Intenta comando nuevo (Trouble v3)
  if pcall(vim.cmd, "Trouble " .. cmd_new) then
    return
  end
  -- Fallback a comando legacy (Trouble v1/v2)
  if not pcall(vim.cmd, "TroubleToggle " .. cmd_legacy) then
    vim.notify("Trouble: comando no disponible", vim.log.levels.WARN)
  end
end

map("n", "<leader>xx", function()
  trouble_cmd("diagnostics toggle", "document_diagnostics")
end, { desc = "Diagnósticos" })

map("n", "<leader>xw", function()
  trouble_cmd("workspace_diagnostics toggle", "workspace_diagnostics")
end, { desc = "Diagnósticos del workspace" })

map("n", "<leader>xd", function()
  trouble_cmd("document_diagnostics toggle", "document_diagnostics")
end, { desc = "Diagnósticos del documento" })

map("n", "<leader>xq", function()
  trouble_cmd("quickfix toggle", "quickfix")
end, { desc = "Quickfix" })

-- Bufferline
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Siguiente buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer anterior" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Cerrar buffer" })

-- ============================================================
-- DAP (Debugging)
-- ============================================================
map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Iniciar/Continuar" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Condición: ')) end, { desc = "Debug: Breakpoint condicional" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Debug: Abrir REPL" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Debug: Run Last" })
map("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Debug: Terminar" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })
map("n", "<leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Debug: Hover" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnósticos" })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics toggle<cr>", { desc = "Workspace diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics toggle<cr>", { desc = "Documento diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix" })
