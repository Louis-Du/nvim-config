require("noice").setup({
  lsp = {
    progress = { enabled = false }, -- Desactivar notificaciones LSP de noice
    hover = { enabled = true },
    signature = { enabled = true },
  },
  notify = {
    enabled = false, -- Desactivar notificaciones de noice
  },
})
