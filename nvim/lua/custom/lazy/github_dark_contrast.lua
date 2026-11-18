-- Theme
return {
	"Peanutt42/github-dark-contrast-theme.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme github_dark_contrast")
	end,
}
