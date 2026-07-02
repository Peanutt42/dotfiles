-- All non plugin related keymaps

-- Set leader key
vim.g.mapleader = " "

-- make <leader>y and <leader>d copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+yy', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", '"+dd', { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set("v", "<leader>d", '"+d', { noremap = true, silent = true })

-- paste, but keep the copied (normal paste replaces pasted with the overwritten)
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, silent = true })

-- exit insert mode from within insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = false, silent = true })

-- clear search results with Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- Ctrl + H/J/K/L to navigate panels
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Ctrl + n/p to go to next/prev buffer
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", ":bprevious<CR>", { noremap = true, silent = true })

-- Ctrl + f tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux display-popup -E \"tms\"<CR>")
