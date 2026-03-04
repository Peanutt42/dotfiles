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
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"


-- inline diagnostic error messages
vim.diagnostic.enable()
vim.diagnostic.config({ virtual_text = true, virtual_lines = true, update_in_insert = true })

-- Colorscheme: github_dark_contrast
vim.cmd("colorscheme github_dark_contrast")
