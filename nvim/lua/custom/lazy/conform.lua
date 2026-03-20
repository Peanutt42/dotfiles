-- Autoformat
return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>f',
			function() require('conform').format { async = true, lsp_format = 'fallback' } end,
			mode = '',
			desc = '[F]ormat buffer',
		},
	},
	---@module 'conform'
	---@type conform.setupOpts
	opts = {
		notify_on_error = false,
		format_on_save = function(_)
			if vim.g.disable_autoformat then
				return
			end

			return {
				timeout_ms = 500,
				lsp_format = 'fallback',
			}
		end,
		formatters_by_ft = {
			rust = { "rustfmt", lsp_format = "fallback" },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_user_command(
			"DisableAutoformat",
			function()
				vim.g.disable_autoformat = true
			end,
			{ desc = "Disables auto formatting" }
		)
		vim.api.nvim_create_user_command(
			"EnableAutoformat",
			function()
				vim.g.disable_autoformat = false
			end,
			{ desc = "Enables auto formatting" }
		)
	end,
}
