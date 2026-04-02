--[[

every file (not init.lua) defines a lsp server following this config structure:

-- xyz.lua: the name of the lsp is defined through the file's stem, here: 'xyz'
return {
	-- defaults to true if not provided
	-- when false will not install lsp through mason
	mason_ensure_installed = true,

	-- the rest is just `vim.lsp.Config`
	settings = {
		xyz = {
			some_lsp_config = "idk",
		}
	}
}

--]]

---@class ServerConfig: vim.lsp.Config
---@field mason_ensure_installed? boolean

---@class ServerConfigs
---@field mason_ensure_installed string[]
---@field lsp_configs table<string, vim.lsp.Config>

---@type ServerConfigs
local server_configs = {
	mason_ensure_installed = {},
	lsp_configs = {},
}

local servers_dir = vim.fn.stdpath("config") .. "/lua/custom/servers"

for _, file in ipairs(vim.fn.glob(servers_dir .. "/*.lua", false, true)) do
	-- filestem (no extension)
	local server_name = vim.fn.fnamemodify(file, ":t:r")

	if server_name ~= "init" then
		---@type ServerConfig
		local server_config = require("custom.servers." .. server_name)

		if server_config.mason_ensure_installed ~= false then
			table.insert(server_configs.mason_ensure_installed, server_name)
		end

		-- cast `ServerConfig` to `vim.lsp.Config`
		server_config.mason_ensure_installed = nil
		local lsp_config = server_config --[[@as vim.lsp.Config]]

		server_configs.lsp_configs[server_name] = lsp_config
	end
end

return server_configs
