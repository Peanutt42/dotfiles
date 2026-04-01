-- syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"help", "vim", "regex", "markdown", "markdown_inline", "bash",
			"javascript", "typescript", "c", "lua", "rust", "vhdl", "haskell",
			"java", "fish", "nix"
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
