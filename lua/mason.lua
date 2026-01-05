local is_termux = vim.g.is_termux

if is_termux then
  -- LSP mínimo o ninguno
  return
end

-- LSP completo solo en Fedora
local lspconfig = require("lspconfig")

lspconfig.jdtls.setup({})

local opts = { noremap=true, silent=true, buffer=bufnr }

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", 

local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup()

local ok2, mason_lsp = pcall(require, "mason-lspconfig")
if not ok2 then
  return
end

mason_lsp.setup({
  ensure_installed = { "jdtls" },
})
