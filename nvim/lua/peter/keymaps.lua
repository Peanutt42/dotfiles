-- Set leader key
vim.g.mapleader = " "

-- paste, but keep the copied (normal paste replaces pasted with the overwritten)
vim.keymap.set("x", "<leader>p", "\"_dP")
