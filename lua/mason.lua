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
