return {
	"rmagatti/auto-session",
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		git_use_branch_name = true,
		auto_restore_last_session = true,
		bypass_save_filetypes = { "neo-tree" },
		post_restore_cmds = {
			function()
				require("neo-tree.command").execute({
					action = "show",
					reveal = true
				})
			end
		},
		preserve_buffer_on_restore = function(bufnr)
			return vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "neo-tree"
		end
	}
}
