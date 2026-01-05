-- Si estamos en Termux, no cargamos LSP
if vim.g.is_termux then
  return
end

-- Mason
local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
  return
end

mason.setup()

-- Mason LSP
local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then
  return
end

mason_lspconfig.setup({
  ensure_installed = { "jdtls" },
})

-- LSPConfig
local ok_lsp, lspconfig = pcall(require, "lspconfig")
if not ok_lsp then
  return
end

lspconfig.jdtls.setup({})
