---@type ServerConfig
return {
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true,
			check = { command = 'clippy' },
			inlayHints = {
				parameterHints = true,
				typeHints = true,
				chainingHints = true,
			},
		}
	}
}
