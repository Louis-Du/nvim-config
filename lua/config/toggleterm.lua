-- config/toggleterm.lua - Configuración para terminal integrada

require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]], -- Ctrl + \ para abrir/cerrar terminal
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float'
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
    width = math.floor(vim.o.columns * 0.85),
    height = math.floor(vim.o.lines * 0.85),
    winblend = 0,
  },
})

-- Atajos para diferentes tipos de terminales
local Terminal = require('toggleterm.terminal').Terminal

-- Terminal flotante (ya configurada con Ctrl+\)
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', 
  { desc = 'Terminal flotante' })

-- Terminal horizontal
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', 
  { desc = 'Terminal horizontal' })

-- Terminal vertical
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', 
  { desc = 'Terminal vertical' })

-- Terminal en pestaña
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=tab<CR>', 
  { desc = 'Terminal en pestaña' })

-- Atajos para navegar dentro del modo terminal
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts) -- ESC para salir del modo terminal
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)    -- jk alternativa
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts) -- Navegar ventanas
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)   -- Comandos de ventana
end

-- Auto-configurar atajos al abrir terminal
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Terminales específicas para desarrollo
-- Lazygit (si lo tienes instalado)
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

vim.keymap.set('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 
  { desc = 'Lazygit' })

-- HTOP (monitor de sistema)
local htop = Terminal:new({
  cmd = "htop",
  direction = "float",
  hidden = true,
})

function _HTOP_TOGGLE()
  htop:toggle()
end

vim.keymap.set('n', '<leader>to', '<cmd>lua _HTOP_TOGGLE()<CR>', 
  { desc = 'HTOP monitor' })

-- Python REPL
local python = Terminal:new({
  cmd = "python3",
  direction = "float",
  hidden = true,
})

function _PYTHON_TOGGLE()
  python:toggle()
end

vim.keymap.set('n', '<leader>tp', '<cmd>lua _PYTHON_TOGGLE()<CR>', 
  { desc = 'Python REPL' })

-- Node REPL
local node = Terminal:new({
  cmd = "node",
  direction = "float",
  hidden = true,
})

function _NODE_TOGGLE()
  node:toggle()
end

vim.keymap.set('n', '<leader>tn', '<cmd>lua _NODE_TOGGLE()<CR>', 
  { desc = 'Node REPL' })
