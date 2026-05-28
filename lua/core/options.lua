local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.shortmess:append("I")
vim.cmd("syntax enable")
