-- ============================================================
-- init.lua - Configuración principal de Neovim
-- ============================================================

-- Definir leader antes de cargar plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Cargar opciones básicas
require("core.options")

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
safe_require("config.theme")
safe_require("config.lualine")
safe_require("config.indent")
safe_require("config.noice")


-- Inicializar DAP
local dap_ok = safe_require("config.dap")
if dap_ok then
  require("config.dap").setup()
end

safe_require("config.dap-java")

require("core.diagnostics")
require("core.keymaps")
require("core.dashboard")

