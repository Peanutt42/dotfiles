---@type ServerConfig
return {
	filetypes = {
		'c',
		'css',
		'gitcommit',
		'go',
		'haskell',
		'html',
		'java',
		'javascript',
		'javascriptreact',
		'lua',
		'markdown',
		'php',
		'python',
		'ruby',
		'rust',
		'swift',
		'toml',
		'text',
		'typescript',
		'typescriptreact',
		'zig',
		'nix',
		'just',
		'wgsl',
		'wesl'
	},
	-- only runs codebook-lsp if a codebook.toml or .codebook.toml file is present in the project
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { 'codebook.toml', '.codebook.toml' })
		if root then
			on_dir(root)
		end
	end,
	single_file_support = false,
}
