return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	opts = {
		preset = "simple",
		options = {
			use_icons_from_diagnostic = true,
			set_arrow_to_diag_color = true,
			multilines = {
				enabled = true,
				always_show = true,
			},
			throttle = 0,
			enable_on_insert = true,
		}
	},
	config = function(_, opts)
		require("tiny-inline-diagnostic").setup(opts)

		-- Disable Neovim's default virtual text diagnostics
		vim.diagnostic.config({ virtual_text = false })
	end,
}
