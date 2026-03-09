return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({})

		vim.keymap.set("n", "<leader>t", function() vim.cmd [[ToggleTerm]] end)
	end
}
