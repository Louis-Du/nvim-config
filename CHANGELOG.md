# Changelog - Mejoras de Configuración

## Fecha: 19 de enero de 2026

### 🔴 Errores Críticos Corregidos

#### 1. Conflicto de Keymaps DAP
**Problema:** `<leader>dt` estaba asignado a dos funciones:
- Terminar debugger en `lua/core/keymaps.lua`
- Ejecutar test de clase en `ftplugin/java.lua`

**Solución:**
- ✅ Cambié `<leader>dt` → `<leader>dT` para "Terminar DAP"
- ✅ Renombré pruebas Java: `<leader>dn` → `<leader>tm` y `<leader>dt` → `<leader>tc`
- ✅ Actualicé `which-key.lua` con nuevos atajos

#### 2. Inconsistencia en Consola DAP
**Problema:** `dap-java.lua` usaba `internalConsole` pero `lsp.lua` esperaba `integratedTerminal`

**Solución:**
- ✅ Sincronizados ambos archivos usando `integratedTerminal`
- ✅ Agregadas notificaciones visuales en listeners de DAP

---

### 🟡 Mejoras de Robustez

#### 3. Auto-install de Treesitter Deshabilitado
**Problema:** `auto_install = true` descargaba parsers sin confirmación del usuario

**Cambio:**
```lua
-- Antes
auto_install = true

-- Ahora
auto_install = false
```
**Impacto:** Previene descargas no solicitadas y respeta el control del usuario

#### 4. Función Unused Eliminada
**Problema:** `nvimtree.lua` tenía `_G.safe_toggle()` que nunca se usaba

**Cambio:** Removida completamente

#### 5. Format.lua - Error Handling Mejorado
**Problema:** 
- No capturaba errores de formateo
- Timeout muy bajo (2000ms) para proyectos grandes

**Cambio:**
```lua
-- Ahora con try-catch y timeout aumentado
local ok, err = pcall(vim.lsp.buf.format, {
  async = false,
  timeout_ms = 5000,  -- Aumentado de 2000
})
if not ok then
  vim.notify("Format error: " .. tostring(err), vim.log.levels.WARN)
end
```

---

### 🟠 Mejoras de Experiencia

#### 6. Autocompletado (CMP) Mejorado
**Cambio:** Agregada configuración de `completeopt`
```lua
completion = {
  completeopt = 'menu,menuone,noselect',
}
```
**Beneficio:** Mejor control visual del autocompletado

#### 7. Notificaciones de Estado DAP
**Cambio:** Agregados `vim.notify()` en listeners de DAP

```lua
dap.listeners.after.event_initialized["dapui_java"] = function()
  dapui.open()
  vim.notify("✓ Debugger started", vim.log.levels.INFO)
end

dap.listeners.before.event_terminated["dapui_java"] = function()
  dapui.close()
  vim.notify("✗ Debugger terminated", vim.log.levels.WARN)
end
```
**Beneficio:** Usuario sabe el estado del debugger en tiempo real

#### 8. Keymaps de Portapapeles Deprecados
**Cambio:** Comentados en `init.lua` con advertencia
```lua
-- Estos atajos pueden causar conflictos. 
-- Considera usar los atajos nativos de Neovim: 
-- y para copiar, d para cortar, etc.
```
**Razón:** Pueden interferir con otros plugins y conflictuar con Vim

---

## Resumen de Cambios

| Archivo | Cambios |
|---------|---------|
| `lua/core/keymaps.lua` | ✅ Cambié `<leader>dt` a `<leader>dT` |
| `lua/config/dap-java.lua` | ✅ Console a `integratedTerminal`, agregadas notificaciones |
| `lua/config/treesitter.lua` | ✅ `auto_install = false` |
| `lua/config/nvimtree.lua` | ✅ Eliminada función `_G.safe_toggle()` |
| `lua/config/format.lua` | ✅ Error handling y timeout aumentado |
| `lua/config/cmp.lua` | ✅ Agregada configuración `completeopt` |
| `lua/config/whichkey.lua` | ✅ Actualizado con nuevos atajos `t` (test) |
| `ftplugin/java.lua` | ✅ Renombrados atajos: `tm` (test method), `tc` (test class) |
| `init.lua` | ✅ Keymaps de portapapeles comentados |

---

## Nuevos Atajos de Teclado

### Debug (Cambios)
- `<leader>dT` - **Terminar** (era `dt`)

### Test (Java) - **NUEVO**
- `<leader>tm` - Test método actual (era `<leader>dn`)
- `<leader>tc` - Test clase (era `<leader>dt`)

---

## Próximas Mejoras Sugeridas

- [ ] Agregar esquema de colores consistente
- [ ] Documentar instalación de JDTLS en README
- [ ] Agregar snippets adicionales para Java
- [ ] Configurar lint automático
- [ ] Agregar integración con Git
