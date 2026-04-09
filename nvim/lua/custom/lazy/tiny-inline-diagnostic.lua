return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "simple",
			options = {
				use_icons_from_diagnostic = true,
				set_arrow_to_diag_color = true,
				multilines = {
					enabled = true,
					always_show = true,
				},
			}
		})

		-- Disable Neovim's default virtual text diagnostics
		vim.diagnostic.config({ virtual_text = false })
	end,
}
