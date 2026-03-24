if vim.fn.exists("syntax_on") ~= 1 then
	vim.cmd("syntax enable")
end

vim.cmd("filetype plugin indent on")
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

-- Folding
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Files
vim.o.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.updatetime = 200
vim.opt.autoread = true
vim.o.fixendofline = false

-- UI
vim.o.number = true
vim.o.cursorline = true
vim.o.cursorlineopt = "screenline,number"
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "+1"
vim.o.showmode = false
vim.o.ruler = false
vim.o.shortmess = "CFOSWaco"
vim.o.fillchars = "eob: ,fold:╌"
vim.o.list = true

vim.opt.listchars = {
	tab = "⇒ ",
	trail = "·",
	extends = "›",
	precedes = "‹",
}
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"

-- Splits
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "screen"

-- Indentation & tabs
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftround = true
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.infercase = true

-- Editing
vim.o.mouse = "a"
vim.o.virtualedit = "block"
vim.o.iskeyword = "@,48-57,_,192-255,-"
vim.o.spelloptions = "camel"
vim.o.formatoptions = "rqnl1j"
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Completion
vim.o.complete = ".,w,b,kspell"
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
vim.o.completetimeout = 100
