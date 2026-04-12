---@type ServerConfig
return {
	settings = {
		["rust-analyzer"] = {
			-- we dont need `checkOnSave`, as rust-analyzer already gives us all the errors we need.
			-- this option can dublicate macro errors, as both rust-analyzer and the `cargo check/clippy` report the macro error
			checkOnSave = false,

			-- if for some reason i someday need to have the accurate `cargo check/clippy` output, here it is
			-- checkOnSave = true,
			-- check = { command = 'clippy' },
		}
	}
}
