return {
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
		---@type table<string, vim.lsp.Config>
		local servers = {
			rust_analyzer = {
				settings = {
					['rust-analyzer'] = {
						checkOnSave = true,
						check = {
							command = "clippy",
						},
					}
				}
			},
			lua_ls = {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							version = 'LuaJIT',
							path = { 'lua/?.lua', 'lua/?/init.lua' },
						},
						workspace = {
							checkThirdParty = false,
							-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
							--  See https://github.com/neovim/nvim-lspconfig/issues/3189
							library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
								'${3rd}/luv/library',
								'${3rd}/busted/library',
							}),
						},
					})
				end,
				settings = {
					Lua = {},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers)
		require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

		for name, server in pairs(servers) do
			vim.lsp.config(name, server)
			vim.lsp.enable(name)
		end

		-- manually installed through a system package
		vim.lsp.enable("nixd")

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
			}
		})
		vim.lsp.enable("clangd")
		vim.lsp.enable("clang-format")
	end
}
