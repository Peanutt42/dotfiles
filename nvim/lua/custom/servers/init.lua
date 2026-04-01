--[[

every file (not init.lua) defines a lsp server following this config structure:

-- xyz.lua
return {
	# defaults to true if not provided
	mason_ensure_installed = true,
	# TODO: add option to custom config call: see jdtls
	settings = {
		xyz = {
			some_lsp_config = "idk",
		}
	}
	... rest of the configuration fields
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

-- TODO: use current filepath
local path = vim.fn.stdpath("config") .. "/lua/custom/servers"

for _, file in ipairs(vim.fn.glob(path .. "/*.lua", false, true)) do
	local name = vim.fn.fnamemodify(file, ":t:r")

	if name ~= "init" then
		---@type ServerConfig
		local server_config = require("custom.servers." .. name)
		if server_config.mason_ensure_installed ~= false then
			table.insert(server_configs.mason_ensure_installed, name)
		end

		server_config.mason_ensure_installed = nil
		local lsp_config = server_config --[[@as vim.lsp.Config]]
		server_configs.lsp_configs[name] = lsp_config
	end
end

return server_configs
