local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup({
  window = {
    border = "rounded",
  },
  layout = {
  spacing = 6,
  align = "center",
},
})

wk.register({
  f = {
    name = "🔍 Buscar",
    f = "Archivos",
    g = "Texto",
    b = "Buffers",
    s = "Símbolos",
  },

  e = "📂 Explorador",

  o = "📍 Enfocar árbol",
  r = "📍 Archivo actual",
  R = "🔄 Refrescar árbol",

  b = {
    name = "📁 Buffers",
    d = "Cerrar buffer",
  },

  x = {
    name = "⚠ Diagnósticos",
    x = "Todos",
    w = "Workspace",
    d = "Documento",
    q = "Quickfix",
  },

  d = {
    name = "🐞 Debug",
    b = "Breakpoint",
    B = "Breakpoint condicional",
    c = "Continuar",
    r = "REPL",
    l = "Run last",
    T = "Terminar",
    u = "UI",
    h = "Hover",
    v = "Vista",
  },

  r = {
    name = "📖 Reader",
    r = "Modo lectura",
  },

  y = "📋 Copiar todo",
  D = "🔎 Ver diagnóstico flotante",

}, { prefix = "<leader>" })

