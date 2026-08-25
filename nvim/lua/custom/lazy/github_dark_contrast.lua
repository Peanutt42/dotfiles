-- Theme
return {
	"Peanutt42/github-dark-contrast-theme.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme github_dark_contrast")

		-- make text buffers transparent when the terminal itself is also transparent
		vim.cmd([[
			highlight Normal guibg=none ctermbg=none
			highlight NormalNC guibg=none ctermbg=none
			highlight NonText guibg=none ctermbg=none
			highlight SignColumn guibg=none ctermbg=none
		]])
	end,
}
