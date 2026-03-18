-- display error messages as actual "notification" messages
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
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
	}
}
