local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup({})

wk.register({
  { "<leader>e", group = "Explorador" },
  { "<leader>f", group = "Buscar" },
  { "<leader>l", group = "LSP" },
})
