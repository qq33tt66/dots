local g = vim.g
local o = vim.o
local opt = vim.opt
o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.cursorline = true
o.relativenumber = true
o.cursorlineopt = "number"
o.swapfile = false
o.completeopt = 'menuone,noinsert,noselect'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.winborder = 'rounded'
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.guicursor = ""
-- vim.cmd('syntax off')
vim.opt.undofile = true


vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.filetype.plugin = true
vim.cmd("filetype plugin indent on")
g.mapleader = " "
