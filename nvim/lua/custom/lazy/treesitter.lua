-- syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust", "bash", "fish" },
		sync_install = false,
		auto_install = true,
		indent = {
			enable = true,
		},
		highlight = {
			enable = true,
		}
	}
}
