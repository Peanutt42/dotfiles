return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		require("noice").setup({
			cmdline = {
				view = "cmdline",
			},
			messages = {
				view = "mini",
				view_error = "mini",
				view_warn = "mini",
			},
			views = {
				mini = {
					backend = "mini",
					reverse = false,
				},
			},
		})
	end
}
