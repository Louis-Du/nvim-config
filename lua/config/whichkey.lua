local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then return end

wk.register({
  { "<leader>e", group = "Explorador" },
  { "<leader>f", group = "Buscar" },
  { "<leader>l", group = "LSP" },
})
