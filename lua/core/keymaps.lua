
local map = vim.keymap.set

-- Telescope
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Buscar archivos" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Buscar texto" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Buffers abiertos" })
map("n", "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, { desc = "Símbolos LSP" })

-- NvimTree
map("n", "<leader>e", function() require("nvim-tree.api").tree.toggle() end, { desc = "Explorador archivos" })
map("n", "<leader>o", function() require("nvim-tree.api").tree.focus() end, { desc = "Foco explorador" })
map("n", "<leader>r", ":NvimTreeFindFile<CR>", { desc = "Resaltar archivo actual" })
map("n", "<leader>R", ":NvimTreeRefresh<CR>", { desc = "Actualizar árbol" })

-- Navegación entre ventanas
map("n", "<C-h>", "<C-w>h", { desc = "Ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ventana abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ventana arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Ventana derecha" })

-- Trouble (diagnósticos)
local function trouble_cmd(cmd_new, cmd_legacy)
  if pcall(vim.cmd, "Trouble " .. cmd_new) then return end
  if not pcall(vim.cmd, "TroubleToggle " .. cmd_legacy) then
    vim.notify("Trouble: comando no disponible", vim.log.levels.WARN)
  end
end
map("n", "<leader>xx", function()
  trouble_cmd("diagnostics toggle", "document_diagnostics")
end, { desc = "Ver todos los diagnósticos (Trouble)" })
map("n", "<leader>xw", function()
  trouble_cmd("workspace_diagnostics toggle", "workspace_diagnostics")
end, { desc = "Diagnósticos del workspace (Trouble)" })
map("n", "<leader>xd", function()
  trouble_cmd("document_diagnostics toggle", "document_diagnostics")
end, { desc = "Diagnósticos del documento actual (Trouble)" })
map("n", "<leader>xq", function()
  trouble_cmd("quickfix toggle", "quickfix")
end, { desc = "Lista Quickfix (Trouble)" })

-- =================== Bufferline ===================
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Ir al siguiente buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Ir al buffer anterior" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Cerrar buffer actual" })

-- =================== DAP (Debugging) ===================
map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Iniciar o continuar ejecución" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Saltar sobre (step over)" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Entrar (step into)" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Salir (step out)" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Alternar breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Condición: ')) end, { desc = "Debug: Breakpoint condicional" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Debug: Abrir consola REPL" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Debug: Ejecutar última sesión" })
map("n", "<leader>dT", function() require("dap").terminate() end, { desc = "Debug: Terminar depuración" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug: Mostrar/ocultar UI" })
map("n", "<leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Debug: Información en hover" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Debug: Continuar ejecución" })
map("n", "<leader>dv", function() require("config.dap").toggle_full_view() end, { desc = "Debug: Vista completa/simple" })

-- Diagnóstico flotante (cambié el atajo para evitar conflicto con nvim-tree)
map("n", "<leader>.D", vim.diagnostic.open_float, { desc = "diag float" })

-- ===========================================================
-- Reader
-- ===========================================================
map("n", "<leader>.r", "<cmd>Reader<CR>", { desc = "reader" })

-- ===========================================================
-- Copiar todo
-- ===========================================================
map("n", "<leader>.y", function()
  vim.cmd("%y+")
end, { desc = "copy file" })

