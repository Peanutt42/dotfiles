-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Basics
vim.o.number = true
vim.o.relativenumber = false
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd([[
  filetype plugin indent on
]])
vim.o.colorcolumn = "80"
vim.o.whichwrap = "b,s,h,l,<,>,[,]"
vim.o.hlsearch = false
vim.o.incsearch = true


-- inline diagnostic error messages
vim.diagnostic.enable()
vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = true,
	update_in_insert = true
})


-- hide cmdline when not used
vim.o.cmdheight = 0
