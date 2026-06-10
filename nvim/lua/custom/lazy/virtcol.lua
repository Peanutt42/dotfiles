-- custom super thin 80-char indication bar
return {
	"lukas-reineke/virt-column.nvim",
	---@module 'virt-column'
	---@type virtcolumn.config
	opts = {
		char = "▏",
		highlight = "VirtColumn"
	},
	config = function(_, opts)
		require("virt-column").setup(opts)
		vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#2F3337" })
	end,
}
