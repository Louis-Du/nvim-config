local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  window = {
    border = "single",
    position = "bottom",
  },
})

-- Registrar descripciones de grupos de teclas
wk.register({
  f = {
    name = "Buscar",
    f = "Archivos",
    g = "Texto",
    b = "Buffers",
    s = "Símbolos LSP",
  },
  d = {
    name = "Debug",
    c = "Continue",
    s = "Step Over",
    i = "Step Into",
    o = "Step Out",
    b = "Toggle Breakpoint",
    B = "Conditional Breakpoint",
    r = "Open REPL",
    l = "Run Last",
    u = "Toggle UI",
    t = "Terminate",
  },
  e = "Explorador archivos",
  r = "Encontrar archivo",
  R = "Refrescar árbol",
  c = { name = "Código" },
}, { prefix = "<leader>" })
