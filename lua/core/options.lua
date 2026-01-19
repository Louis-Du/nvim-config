local opt = vim.opt

-- Números de línea
opt.number = true
opt.relativenumber = true

-- Indentación
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

-- UI y comportamiento
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.shortmess:append("I")

-- Habilitar sintaxis
vim.cmd("syntax enable")
