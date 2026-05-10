-- syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"help", "vim", "regex", "markdown", "markdown_inline", "bash",
			"c", "lua", "rust", "vhdl", "haskell",
			"java", "fish", "nix",
			-- web-dev:
			"javascript", "typescript", "tsx", "html", "css"
		},
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
