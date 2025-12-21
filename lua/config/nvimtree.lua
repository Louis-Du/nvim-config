local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then return end

-- Toggle seguro (sin buffers duplicados)
function _G.safe_toggle()
  local api = require("nvim-tree.api")
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.tree.open()
  end
end

nvim_tree.setup({
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
    end

    -- Navegación mobile-friendly
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Cerrar nodo"))
    vim.keymap.set('n', 'l', api.node.open.edit, opts("Abrir"))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts("Vertical split"))
    vim.keymap.set('n', 's', api.node.open.horizontal, opts("Horizontal split"))
  end,

  view = {
    width = 30,
    side = "left",
    adaptive_size = true,
  },

  renderer = {
    group_empty = true,
    icons = {
      show = { git = true, folder = true, file = true },
    },
  },

  filters = {
    dotfiles = false,
  },
})
