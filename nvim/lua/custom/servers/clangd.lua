---@type ServerConfig
return {
	mason_ensure_installed = false,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
	}
}
