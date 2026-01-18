local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup({
  window = {
    border = "single",
    position = "bottom",
  },
})

x = {
  name = "Diagnósticos",
  x = "Todos",
  w = "Workspace",
  d = "Documento",
  q = "Quickfix",
},
wk.register({
  f = {
    name = "Buscar",
    f = "Archivos",
    g = "Texto",
    b = "Buffers",
    s = "Símbolos LSP",
  },
  b = {
    name = "Buffers",
    d = "Cerrar buffer",
  },
  e = "Explorador archivos",
  r = "Encontrar archivo",
  R = "Refrescar árbol",
}, { prefix = "<leader>" })
