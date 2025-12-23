local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup({
  plugins = {
    marks = false,
    registers = false,
  },
  window = {
    border = "rounded",
    position = "bottom",
  },
  layout = {
    spacing = 4,
    align = "left",
  },
})

wk.register({
  e = { "Explorador" },
  f = {
    name = "Buscar",
    f = "Archivos",
    g = "Texto",
    b = "Buffers",
    s = "Símbolos LSP",
  },
}, { prefix = "<leader>" })
