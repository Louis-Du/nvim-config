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

safe_require("config.lsp")
safe_require("config.cmp")
safe_require("config.treesitter")
safe_require("config.nvimtree")
safe_require("config.autopairs")
safe_require("config.comment")
safe_require("config.format")
safe_require("config.telescope")
safe_require("config.luasnip")
safe_require("config.trouble")
safe_require("config.whichkey")
safe_require("config.bufferline")


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
-- Portapapeles y seleccionar todo - DEPRECATED
-- (Estos atajos pueden causar conflictos. Considera usar los
--  atajos nativos de Neovim: y para copiar, d para cortar, etc.)
-- ============================================================
-- vim.keymap.set("v", "<C-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
-- vim.keymap.set("n", "<C-c>", '"+yy', { silent = true, desc = "Copy line to clipboard" })
-- vim.keymap.set("v", "<C-x>", '"+d', { silent = true, desc = "Cut to clipboard" })
-- vim.keymap.set("n", "<C-x>", '"+dd', { silent = true, desc = "Cut line to clipboard" })
-- vim.keymap.set("n", "<C-p>", '"+p', { silent = true, desc = "Paste from clipboard" })
-- vim.keymap.set("v", "<C-p>", '"+p', { silent = true, desc = "Paste from clipboard" })
-- vim.keymap.set("n", "<C-a>", "ggVG", { silent = true, desc = "Select all" })

-- LSP keymaps están definidos en config/lsp.lua
