require("neoconf").setup()

-- LSP setup
-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls" },
})

-- Default LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Modern setup: mason-lspconfig auto-starts LSPs via handlers
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local config = {
				capabilities = capabilities,
			}

			-- Special settings for Lua
			if server_name == "lua_ls" then
				config.settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				}
			end

			vim.lsp.config[server_name] = config
			vim.lsp.start(config)
		end,
	},
})

-- Autocomplete lsp setup
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nixd lsp setup:
vim.lsp.enable('nixd')


if vim.lsp.config.rust_analyzer then
	-- rust-analyzer cant access system cargo
	vim.lsp.config.rust_analyzer.cmd = { "rust-analyzer" } -- skip cargo root detection
	vim.lsp.config.rust_analyzer.capabilities = cmp_capabilities;
end
-- set rust_analyzer to use clippy instead of check
vim.lsp.config('rust_analyzer', {
	settings = {
		['rust-analyzer'] = {
			checkOnSave = true,
			check = {
				command = "clippy",
			},
		},
	},
})
vim.lsp.enable('rust_analyzer')

