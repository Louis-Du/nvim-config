-- ============================================================
-- init.lua - Configuración principal de Neovim
-- ============================================================

require("core.options") 

-- Cargar opciones básicas
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Opciones básicas
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
local function safe_require(module)
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Error loading " .. module .. ": " .. tostring(err), vim.log.levels.WARN)
  end
  return ok
end

safe_require("config.cmp")
safe_require("config.treesitter")
safe_require("config.nvimtree")
safe_require("config.autopairs")
safe_require("config.comment")
safe_require("config.format")
safe_require("config.telescope")
safe_require("config.luasnip")
safe_require("config.whichkey")
safe_require("config.bufferline")
safe_require("config.trouble")

-- Inicializar DAP
local dap_ok = safe_require("config.dap")
if dap_ok then
  require("config.dap").setup()
end

safe_require("config.dap-java")

-- ============================================================
-- Cargar keymaps DESPUÉS de que los plugins estén inicializados
-- ============================================================
require("core.keymaps")

-- ============================================================
-- Portapapeles
-- ============================================================
vim.keymap.set("v", "<C-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "<C-c>", '"+yy', { silent = true, desc = "Copy line to clipboard" })
vim.keymap.set("v", "<C-x>", '"+d', { silent = true, desc = "Cut to clipboard" })
vim.keymap.set("n", "<C-x>", '"+dd', { silent = true, desc = "Cut line to clipboard" })
vim.keymap.set("n", "<C-p>", '"+p', { silent = true, desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-p>", '"+p', { silent = true, desc = "Paste from clipboard" })
vim.keymap.set("n", "<C-a>", "ggVG", { silent = true, desc = "Select all" })

-- ============================================================
-- LSP keymaps
-- ============================================================
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
