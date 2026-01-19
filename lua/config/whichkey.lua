local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup({
  window = {
    border = "single",
    position = "bottom",
  },
})

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
  x = {
    name = "Diagnósticos",
    x = "Todos",
    w = "Workspace",
    d = "Documento",
    q = "Quickfix",
  },
  d = {
    name = "Debug",
    b = "Toggle Breakpoint",
    B = "Breakpoint condicional",
    r = "Abrir REPL",
    l = "Run Last",
    t = "Terminar",
    u = "Toggle UI",
    h = "Hover",
    c = "Continuar",
    v = "Vista completa/simple",
  },
  e = "Explorador archivos",
  r = "Encontrar archivo",
  R = "Refrescar árbol",
}, { prefix = "<leader>" })
