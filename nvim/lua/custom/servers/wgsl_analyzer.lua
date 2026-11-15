---@type ServerConfig
return {
	filetypes = { "wgsl", "wesl" },
	register_callback = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = function()
				require("nvim-treesitter.parsers").wesl = {
					install_info = {
						url = "https://github.com/webgpu-tools/tree-sitter-wesl",
						queries = "queries/nvim",
					},
				}
			end,
		})

		vim.filetype.add({
			extension = {
				wesl = "wesl",
			},
		})

		vim.treesitter.language.register("wesl", { "wgsl", "wesl" })

		require('nvim-treesitter').install("wesl")
	end
}
