-- Autoformat
return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo', 'Format', 'DisableFormatOnSave', 'EnableFormatOnSave' },
	keys = {
		{
			'<leader>f',
			function() vim.cmd("Format") end,
			mode = '',
			desc = '[F]ormat buffer',
		},
	},
	---@module 'conform'
	---@type conform.setupOpts
	opts = {
		notify_on_error = false,
		format_on_save = function(_)
			if vim.g.disable_format_on_save then
				return
			end

			return {
				timeout_ms = 500,
				lsp_format = 'fallback',
			}
		end,
		formatters_by_ft = {
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_user_command(
			"DisableFormatOnSave",
			function()
				vim.g.disable_format_on_save = true
			end,
			{ desc = "Disables auto formatting on save" }
		)
		vim.api.nvim_create_user_command(
			"EnableFormatOnSave",
			function()
				vim.g.disable_format_on_save = false
			end,
			{ desc = "Enables auto formatting on save" }
		)
		vim.api.nvim_create_user_command(
			"Format",
			function()
				require('conform').format({ async = true, lsp_format = 'fallback' })
			end,
			{ desc = "Formats current buffer" }
		)
	end,
}
