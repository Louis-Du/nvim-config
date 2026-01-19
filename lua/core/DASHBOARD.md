# Dashboard Minimalista

## Filosofía

El dashboard es un **espacio de entrada**, no un panel de control.  
Aparece solo cuando abres Neovim sin archivos.  
Desaparece cuando empiezas a trabajar.

## Acciones Disponibles

| Tecla | Acción | Descripción |
|-------|--------|-------------|
| `n` | Nuevo archivo | Crea un buffer vacío |
| `f` | Buscar archivo | Abre Telescope para buscar archivos |
| `r` | Recientes | Lista archivos recientemente abiertos |
| `e` | Explorador | Abre nvim-tree |
| `q` | Salir | Cierra Neovim |

## Comportamiento

- **Aparece solo al iniciar sin archivos**
- **Desaparece automáticamente** al abrir cualquier archivo
- **Keymaps locales**: las teclas solo funcionan en el dashboard
- **Buffer temporal**: no aparece en la lista de buffers

## Personalización

### Cambiar mensajes

Edita el array `messages` en [dashboard.lua](dashboard.lua):

```lua
local messages = {
  "Tu mensaje aquí.",
  "Otro mensaje inspirador.",
}
```

### Agregar/modificar acciones

En la función `M.setup()`, modifica la sección de keymaps:

```lua
map("t", "<cmd>terminal<CR>", "Abrir terminal")  -- Nueva acción
```

Y agrega la línea correspondiente al contenido:

```lua
local lines = {
  "",
  msg,
  "",
  "  [n]  Nuevo archivo",
  "  [f]  Buscar archivo",
  "  [r]  Recientes",
  "  [e]  Explorador",
  "  [t]  Terminal",  -- Nueva línea
  "  [q]  Salir",
  "",
}
```

### Cambiar estilo visual

Ajusta la configuración del buffer en la sección `vim.cmd([[ ... ]])`:

```lua
vim.cmd([[
  setlocal
    nonumber          -- Sin números de línea
    norelativenumber  -- Sin números relativos
    nocursorline      -- Sin línea del cursor
    nospell           -- Sin corrector
    signcolumn=no     -- Sin columna de signos
]])
```

## Próximos Niveles

Ideas para expandir (cuando quieras):

- **Mensajes contextuales** según hora del día
- **Información del proyecto** detectada automáticamente
- **Estadísticas sutiles** (archivos recientes, líneas escritas)
- **Colores dinámicos** que cambien con el tema
- **Fade-in animation** para entrada suave

## Principio

> Un buen dashboard no impresiona.  
> **Acompaña.**
