# nvim-config

Configuración personalizada de Neovim orientada al desarrollo de software moderno, con soporte completo para LSP (Language Server Protocol), autocompletado inteligente, navegación de archivos y snippets.

## Descripción

Este repositorio contiene una configuración modular y extensible de Neovim construida con Lua y Vim Script. La configuración está diseñada para proporcionar un entorno de desarrollo eficiente con características similares a un IDE moderno, incluyendo:

- Servidor de lenguaje (LSP) para análisis de código en tiempo real
- Autocompletado inteligente con múltiples fuentes
- Navegación rápida de archivos y búsqueda fuzzy
- Resaltado de sintaxis avanzado con Treesitter
- Explorador de archivos integrado
- Snippets personalizables
- Formateo automático de código

## Objetivo

Proporcionar una configuración de Neovim lista para usar que combine potencia, velocidad y facilidad de uso, eliminando la necesidad de configurar múltiples plugins desde cero.

## Público Objetivo

- Desarrolladores que desean migrar a Neovim desde otros editores
- Usuarios de Neovim que buscan una configuración base sólida y extensible
- Programadores que prefieren un entorno de desarrollo ligero pero completo
- Cualquier persona interesada en optimizar su flujo de trabajo en terminal

## Requisitos Previos

Antes de instalar, asegúrate de tener:

- **Neovim** >= 0.8.0 ([Descargar Neovim](https://neovim.io/))
- **Git** (para clonar el repositorio)
- **Node.js** >= 14.0 (requerido por algunos LSP servers)
- **Python 3** con pip (opcional, para algunos plugins)
- **ripgrep** (opcional, para búsqueda mejorada con Telescope)
- **fd** (opcional, para búsqueda de archivos más rápida)

## Instalación

### 1. Hacer Backup de la Configuración Actual

Si ya tienes una configuración de Neovim, haz un respaldo:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

### 2. Clonar el Repositorio

```bash
git clone https://github.com/Louis-Du/nvim-config.git ~/.config/nvim
```

### 3. Instalar vim-plug

Este es el gestor de plugins utilizado en la configuración:

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### 4. Instalar Plugins

Abre Neovim y ejecuta:

```vim
:PlugInstall
```

Espera a que todos los plugins se descarguen e instalen.

### 5. Instalar LSP Servers

Dentro de Neovim, ejecuta:

```vim
:Mason
```

Esto abrirá la interfaz de Mason donde podrás instalar los servidores de lenguaje que necesites (por ejemplo: `pyright` para Python, `ts_ls` para TypeScript/JavaScript, `lua_ls` para Lua, etc.).

### 6. Reiniciar Neovim

Cierra y vuelve a abrir Neovim para que todos los cambios surtan efecto.

## Uso

### Atajos de Teclado Principales

La tecla líder está configurada como `<Space>` (barra espaciadora).

#### Explorador de Archivos (NvimTree)

- `<Space>e` - Abrir/cerrar el explorador de archivos
- `<Space>r` - Encontrar el archivo actual en el árbol
- `<Space>R` - Refrescar el explorador de archivos

#### Búsqueda Fuzzy (Telescope)

- `<Space>ff` - Buscar archivos en el proyecto
- `<Space>fg` - Buscar texto en todos los archivos (live grep)
- `<Space>fb` - Listar y cambiar entre buffers abiertos
- `<Space>fs` - Buscar símbolos en el documento actual

#### Navegación y Edición

- `gcc` - Comentar/descomentar línea actual
- `gc` (modo visual) - Comentar/descomentar selección
- Los pares de caracteres (`()`, `[]`, `{}`, `""`, `''`) se cierran automáticamente

### Comandos Importantes

| Comando | Descripción |
|---------|-------------|
| `:Mason` | Abrir el gestor de LSP servers, linters y formatters |
| `:MasonInstall <nombre>` | Instalar un servidor de lenguaje específico |
| `:LspInfo` | Ver información sobre los LSP servers activos |
| `:TSUpdate` | Actualizar los parsers de Treesitter |
| `:PlugInstall` | Instalar plugins nuevos definidos en `vim/plugins.vim` |
| `:PlugUpdate` | Actualizar todos los plugins instalados |
| `:PlugClean` | Eliminar plugins que ya no están en la configuración |
| `:NvimTreeToggle` | Alternar visibilidad del explorador de archivos |
| `:Telescope` | Abrir el menú principal de Telescope |

### Estructura del Proyecto

```
~/.config/nvim/
├── init.vim                    # Punto de entrada principal
├── vim/
│   └── plugins.vim            # Lista de plugins con vim-plug
├── lua/
│   └── config/
│       ├── cmp.lua            # Configuración de autocompletado
│       ├── lsp.lua            # Configuración de LSP
│       ├── treesitter.lua     # Configuración de Treesitter
│       ├── nvimtree.lua       # Configuración del explorador de archivos
│       ├── telescope.lua      # Configuración de búsqueda fuzzy
│       ├── luasnip.lua        # Configuración de snippets
│       ├── autopairs.lua      # Cierre automático de pares
│       ├── comment.lua        # Comentarios inteligentes
│       └── format.lua         # Formateo automático
└── snippets/                  # Directorio para snippets personalizados
```

## Tecnologías y Herramientas

### Lenguajes

- **Lua** (81.1%) - Lenguaje principal para configuración modular
- **Vim Script** (18.9%) - Configuración base y carga de plugins

### Plugins Principales

| Plugin | Propósito |
|--------|-----------|
| `nvim-lspconfig` | Configuración de Language Server Protocol |
| `mason.nvim` | Gestor de LSP servers, linters y formatters |
| `nvim-cmp` | Motor de autocompletado |
| `LuaSnip` | Motor de snippets |
| `nvim-treesitter` | Resaltado de sintaxis avanzado |
| `nvim-tree.lua` | Explorador de archivos visual |
| `telescope.nvim` | Búsqueda fuzzy de archivos y texto |
| `nvim-autopairs` | Cierre automático de paréntesis, llaves, etc. |
| `Comment.nvim` | Comentarios inteligentes |

### Gestor de Plugins

- **vim-plug** - Gestor de plugins minimalista y rápido

## Personalización

### Añadir Nuevos Plugins

1. Edita `vim/plugins.vim`
2. Añade la línea `Plug 'usuario/nombre-plugin'`
3. Ejecuta `:PlugInstall` en Neovim

### Modificar Atajos de Teclado

Edita el archivo `init.vim` y añade o modifica las líneas que comienzan con `nnoremap`.

### Añadir Soporte para Nuevos Lenguajes

1. Abre `:Mason`
2. Busca el LSP server para tu lenguaje (por ejemplo, `gopls` para Go)
3. Presiona `i` para instalar
4. Reinicia Neovim

## Estado del Proyecto

**Estado:** Activo y en uso personal

Este proyecto se mantiene activamente con actualizaciones periódicas según mis necesidades de desarrollo. Las contribuciones y sugerencias son bienvenidas.

## Autor

**Louis-Du**

- GitHub: [@Louis-Du](https://github.com/Louis-Du)
- Repositorio: [nvim-config](https://github.com/Louis-Du/nvim-config)

## Licencia

Este proyecto está disponible como referencia y uso personal. Siéntete libre de usar, modificar y adaptar esta configuración a tus necesidades.

## Soporte y Contribuciones

Si encuentras algún problema o tienes sugerencias de mejora:

1. Abre un [Issue](https://github.com/Louis-Du/nvim-config/issues)
2. Describe el problema o la mejora propuesta
3. Proporciona información sobre tu sistema operativo y versión de Neovim

---

**Nota:** Esta configuración ha sido probada principalmente en sistemas Linux/macOS. Puede requerir ajustes para Windows.
