-- Set leader key
vim.g.mapleader = " "

-- make <leader>y and <leader>d copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+yy')
vim.keymap.set("n", "<leader>d", '"+dd')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>d", '"+d')

-- paste, but keep the copied (normal paste replaces pasted with the overwritten)
vim.keymap.set("x", "<leader>p", "\"_dP")

-- exit insert mode from within insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = false })

-- clear search results with Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
