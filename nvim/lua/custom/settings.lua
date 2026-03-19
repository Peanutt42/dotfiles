-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.wrap = false
vim.o.cursorline = true
vim.o.updatetime = 250
vim.o.mousemoveevent = true

vim.o.undofile = true
vim.o.swapfile = false

-- Indentation: Tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd("filetype plugin indent on")

vim.o.colorcolumn = "80"
vim.o.whichwrap = "b,s,h,l,<,>,[,]"

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true


-- inline diagnostic error messages
vim.diagnostic.enable()
vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = true,
	update_in_insert = true
})


-- hide cmdline when not used
vim.o.cmdheight = 0


-- enable cursor blinking
vim.opt.guicursor = {
	"n-v:block-blinkwait300-blinkon200-blinkoff150",    -- normal, visual: blinking block
	"i-c-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150", -- insert, command-(insert), visual-exclude: blinking bar
	"r-cr:hor20-blinkwait300-blinkon200-blinkoff150",   -- replace, command-replace: blinking underscore
	"o:hor50",                                          -- operator pending: non-blinking underscore
}

-- enable transparency
vim.g.transparent_enabled = true
