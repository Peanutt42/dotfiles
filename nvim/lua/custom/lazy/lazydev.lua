-- better Lua lsp completions for neovim configs
return {
	"folke/lazydev.nvim",
	ft = "lua",
	---@module 'lazydev'
	---@type lazydev.Config
	opts = {
		library = {
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
}
