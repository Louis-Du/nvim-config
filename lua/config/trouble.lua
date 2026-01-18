
local ok, trouble = pcall(require, "trouble")
if not ok then return end

trouble.setup({
  position = "bottom",
  height = 10,
  -- Nota: no establecer 'icons' como booleano. Dejar valores por defecto
  use_diagnostic_signs = true,
})
