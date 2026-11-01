---@type ServerConfig
return {
	filetypes = { "wgsl", "wesl" },
	register_callback = function()
		vim.filetype.add({
			extension = {
				wesl = "wesl",
			},
		})
		vim.treesitter.language.register("wgsl", "wesl")
	end
}
