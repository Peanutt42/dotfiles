return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "tailwindcss" },
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


		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "crates" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end
}
