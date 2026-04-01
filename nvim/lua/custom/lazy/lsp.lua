return {
	{
		"williamboman/mason-lspconfig.nvim",
		--[[opts = {
			automatic_enable = {
				exclude = {
					-- see 'mfussenegger/nvim-jdtls' (in jdtls.lua)
					'jdtls'
				}
			}
		}]] --
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {},
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local server_configs = require('custom.servers')

			require('mason-tool-installer').setup({
				ensure_installed = server_configs.mason_ensure_installed
			})

			for name, lsp_config in pairs(server_configs.lsp_configs) do
				vim.lsp.config(name, lsp_config)
				vim.lsp.enable(name)
			end
		end
	}
}
