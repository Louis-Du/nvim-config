-- ============================================================
-- init.lua - Configuración principal de Neovim
-- ============================================================

-- Cargar opciones básicas
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Opciones básicas
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.cmd("syntax enable")

-- ============================================================
-- Cargar Packer y plugins
-- ============================================================
require("plugins")

-- ============================================================
-- Configuración de plugins
-- ============================================================
require("config.cmp")
require("config.treesitter")
require("config.nvimtree")
require("config.autopairs")
require("config.comment")
require("config.format")
require("config.telescope")
require("config.luasnip")
require("config.whichkey")

-- ============================================================
-- Keymaps generales
-- ============================================================

-- Explorador de archivos (NvimTree)
vim.keymap.set("n", "<leader>e", ":lua require('nvim-tree.api').tree.toggle()<CR>", { silent = true, desc = "Toggle NvimTree" })
vim.keymap.set("n", "<leader>r", ":NvimTreeFindFile<CR>", { silent = true, desc = "Find file in tree" })
vim.keymap.set("n", "<leader>R", ":NvimTreeRefresh<CR>", { silent = true, desc = "Refresh tree" })

-- Telescope (búsqueda)
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true, desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true, desc = "Buffers" })
vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { silent = true, desc = "LSP symbols" })

-- Portapapeles
vim.keymap.set("v", "<C-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "<C-c>", '"+yy', { silent = true, desc = "Copy line to clipboard" })
vim.keymap.set("v", "<C-x>", '"+d', { silent = true, desc = "Cut to clipboard" })
vim.keymap.set("n", "<C-x>", '"+dd', { silent = true, desc = "Cut line to clipboard" })
vim.keymap.set("n", "<C-p>", '"+p', { silent = true, desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-p>", '"+p', { silent = true, desc = "Paste from clipboard" })
vim.keymap.set("n", "<C-a>", "ggVG", { silent = true, desc = "Select all" })

-- DAP (Debug Adapter Protocol)
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "DAP Continue" })
vim.keymap.set("n", "<leader>ds", function() require("dap").step_over() end, { desc = "DAP Step Over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "DAP Step Into" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate DAP" })

-- LSP keymaps (se establecen cuando LSP se adjunta)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- ============================================================
-- Cargar configuración de DAP
-- ============================================================
require("config.dap").setup()
