-- Fuzzy file(/or anything) finder
return {
	"nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true })
		vim.keymap.set("n", "<C-p>", builtin.find_files, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fg", builtin.git_files, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true })
	end
}
