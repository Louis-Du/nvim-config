# 🐛 Guía de Debugging en Neovim

## 📌 Problema Reportado
El debugger está corriendo pero nunca muestra la salida "Hola mundo".

### ✅ Solución
El programa se pausa en breakpoints. **Debes continuar la ejecución** para ver la salida.

---

## 🎮 Keymaps de Debugging

| Tecla | Acción |
|-------|--------|
| **F5** | 🚀 Iniciar/Continuar ejecución |
| **F10** | ⤵️ Step Over (siguiente línea) |
| **F11** | ↙️ Step Into (entrar en función) |
| **F12** | ↩️ Step Out (salir de función) |
| **<leader>db** | 🔴 Toggle Breakpoint |
| **<leader>dB** | 🟠 Breakpoint condicional |
| **<leader>dc** | ▶️ Continuar |
| **<leader>dr** | 💬 Abrir REPL |
| **<leader>dl** | 🔄 Run Last |
| **<leader>dt** | ⏹️ Terminar |
| **<leader>du** | 🪟 Toggle UI |
| **<leader>dh** | 💭 Hover info |

---

## 📋 Flujo de Debugging típico

### 1. Abrir archivo Java
```bash
nvim src/main/java/Main.java
```

### 2. Colocar breakpoint
- Posiciona el cursor en la línea donde quieres pausar
- Presiona **<leader>db** para colocar un breakpoint

### 3. Iniciar debugging
- Presiona **F5** para comenzar
- El debugger se pausará en el primer breakpoint

### 4. Ver variables
- Las variables se muestran en el panel izquierdo (Scopes)
- Usa **<leader>dh** para ver hover info

### 5. Continuar ejecución
- Presiona **F5** o **<leader>dc** para continuar
- La salida aparecerá en el panel de **Console** (abajo)

### 6. Terminar
- Presiona **<leader>dt** para terminar el debugging

---

## 🖥️ Paneles de DAP-UI

| Panel | Ubicación | Función |
|-------|-----------|---------|
| **Scopes** | Izquierda | Variables locales y parámetros |
| **Breakpoints** | Izquierda | Lista de breakpoints |
| **Stacks** | Izquierda | Call stack |
| **Watches** | Izquierda | Variables que observas |
| **Console** | Abajo | Salida del programa |
| **REPL** | Abajo | Consola interactiva |

---

## 🔍 Ejemplo: Debug de Main.java

```
1. Abre Main.java
2. <leader>db en la línea 3 (System.out.println)
3. F5 para iniciar
4. El programa se pausa en línea 3
5. F5 o <leader>dc para continuar
6. "Hola mundo" aparece en el panel Console
```

---

## ⚠️ Problemas Comunes

### ❌ Programa pausado pero no veo salida
**Solución**: Presiona **F5** o **<leader>dc** para continuar

### ❌ Consola muy pequeña
**Solución**: El tamaño de paneles está optimizado. Puedes redimensionar con mouse

### ❌ Breakpoint no se detiene
**Solución**: Verifica que el LSP de Java esté cargado correctamente

### ❌ DAP no inicia
**Solución**: Asegúrate de que Java y JDTLS estén instalados:
```bash
which jdtls
```

---

## 📁 Configuración

- **Setup**: `lua/config/dap.lua`
- **Keymaps**: `lua/core/keymaps.lua`
- **Java específico**: `lua/config/dap-java.lua`

---

## 💡 Tips

- **Debugging rápido**: Coloca breakpoint → F5 → F5 (ver salida)
- **Inspecciona variables**: Usa **<leader>dh** en hover
- **Breakpoint condicional**: **<leader>dB** + condición (ej: `count > 5`)
- **REPL**: **<leader>dr** para ejecutar código Java mientras está pausado
