local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then return end

nvim_tree.setup({
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
    end

    -- Navegación
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Cerrar nodo"))
    vim.keymap.set('n', 'l', api.node.open.edit, opts("Abrir"))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts("Abrir"))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts("Vertical split"))
    vim.keymap.set('n', 's', api.node.open.horizontal, opts("Horizontal split"))
    
    -- Crear, copiar, pegar, borrar
    vim.keymap.set('n', 'a', api.fs.create, opts("Crear archivo/directorio"))
    vim.keymap.set('n', 'd', api.fs.remove, opts("Borrar"))
    vim.keymap.set('n', 'r', api.fs.rename, opts("Renombrar"))
    vim.keymap.set('n', 'x', api.fs.cut, opts("Cortar"))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts("Copiar"))
    vim.keymap.set('n', 'p', api.fs.paste, opts("Pegar"))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts("Copiar nombre"))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts("Copiar ruta relativa"))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts("Copiar ruta absoluta"))
    
    -- Utilidades
    vim.keymap.set('n', 'R', api.tree.reload, opts("Refrescar"))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts("Toggle archivos ocultos"))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts("Ayuda"))
  end,
  view = { width = 30, side = "left", adaptive_size = true },
  renderer = { group_empty = true, icons = { show = { git = true, folder = true, file = true } } },
  filters = { dotfiles = false },
})
