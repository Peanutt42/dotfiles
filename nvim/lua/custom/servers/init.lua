--[[

every file (not init.lua) defines a lsp server following this config structure:

-- xyz.lua: the name of the mason lsp server is defined through the file's stem, here: 'xyz'
-- (the vim.lsp name can sometimes be different, use lsp_name_override when needed)
return {
	-- defaults to true if not provided
	-- when false will not install lsp through mason
	mason_ensure_installed = true,

	-- defaults to nil, meaning the mason lsp server name will be used for vim.lsp name as well
	lsp_name_override = nil,

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
---@field lsp_name_override? string

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
	local mason_name = vim.fn.fnamemodify(file, ":t:r")

	if mason_name ~= "init" then
		---@type ServerConfig
		local server_config = require("custom.servers." .. mason_name)
		local lsp_name = server_config.lsp_name_override or mason_name

		if server_config.mason_ensure_installed ~= false then
			table.insert(server_configs.mason_ensure_installed, mason_name)
		end

		-- cast `ServerConfig` to `vim.lsp.Config`
		server_config.mason_ensure_installed = nil
		server_config.lsp_name_override = nil
		local lsp_config = server_config --[[@as vim.lsp.Config]]

		server_configs.lsp_configs[lsp_name] = lsp_config
	end
end

return server_configs
