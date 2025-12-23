local wk = require("which-key")

wk.setup({
  plugins = {
    spelling = { enabled = true },
  },
})

wk.register({
  ["<leader>"] = {
    e = "Explorador",
    f = {
      name = "Buscar",
      f = "Archivos",
      g = "Texto",
      b = "Buffers",
      s = "Símbolos",
    },
  },
})
