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
		local server_configs = require('custom.servers')

		require('mason-tool-installer').setup({
			ensure_installed = server_configs.mason_ensure_installed
		})

		for name, lsp_config in pairs(server_configs.lsp_configs) do
			vim.lsp.config(name, lsp_config)
			vim.lsp.enable(name)
		end

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
			callback = function(event)
				vim.keymap.set('n', 'grn', vim.lsp.buf.rename, {
					buffer = event.buf, desc = 'LSP: [R]e[n]ame'
				})
				vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, {
					buffer = event.buf, desc = 'LSP: [G]oto Code [A]ction'
				})
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
					buffer = event.buf, desc = 'LSP: [G]oto [D]efinition'
				})
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
					buffer = event.buf, desc = 'LSP: [G]oto [D]eclaration'
				})

				-- enable inlay hints by default
				vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
				-- toggle inlay hints with <leader>ih
				vim.keymap.set("n", "<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end)
			end,
		})
	end
}
